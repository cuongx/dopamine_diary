import 'dart:async';

import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/l10n/duration_format.dart';
import 'package:dopamine_diary/core/l10n/tier_labels.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/core/utils/show_snackbar.dart';
import 'package:dopamine_diary/features/diary/presentation/log/bloc/activity_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/log/voice_parse_service.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Voice Log — STT thật bằng `speech_to_text` (on-device + network).
/// Flow: tap mic → xin quyền + nghe (partial results hiện trực tiếp) →
/// tự dừng khi im lặng / hết giờ / tap lại → transcript thật → Lưu.
///
/// Phần "AI parse" (transcript → tier/phút/mood) làm ở bước sau; tạm thời
/// transcript được dùng làm tên activity, còn tier/phút/mood để mặc định.
class VoiceLogPage extends StatefulWidget {
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => const VoiceLogPage(),
        fullscreenDialog: true,
      );

  const VoiceLogPage({super.key});

  @override
  State<VoiceLogPage> createState() => _VoiceLogPageState();
}

class _VoiceLogPageState extends State<VoiceLogPage>
    with SingleTickerProviderStateMixin {
  final SpeechToText _speech = SpeechToText();
  final VoiceParseService _parseService = const VoiceParseService();
  bool _speechReady = false;
  List<LocaleName> _locales = const [];

  bool _recording = false;
  bool _hasResult = false;
  String _transcript = '';
  int _elapsedSeconds = 0;
  Timer? _ticker;
  late final AnimationController _waveController;

  // State có thể chỉnh — khởi tạo từ parser, user sửa trước khi lưu.
  final TextEditingController _nameController = TextEditingController();
  DopamineTier _tier = DopamineTier.medium;
  int _duration = 0;
  String _mood = '🙂';

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _initSpeech();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _speech.cancel();
    _waveController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    try {
      _speechReady = await _speech.initialize(
        onStatus: _onSpeechStatus,
        onError: _onSpeechError,
      );
      if (_speechReady) _locales = await _speech.locales();
    } catch (_) {
      _speechReady = false;
    }
    if (mounted) setState(() {});
  }

  /// Khớp ngôn ngữ app (vi/en) với một locale STT có sẵn trên máy.
  /// Trả về null nếu không có → plugin dùng locale mặc định của thiết bị.
  String? _matchLocale(String langCode) {
    for (final l in _locales) {
      final id = l.localeId.toLowerCase().replaceAll('-', '_');
      if (id == langCode || id.startsWith('${langCode}_')) return l.localeId;
    }
    return null;
  }

  void _toggle() => _recording ? _stop() : _start();

  Future<void> _start() async {
    final l10n = AppLocalizations.of(context);
    final langCode = Localizations.localeOf(context).languageCode;
    if (!_speechReady) {
      await _initSpeech();
      if (!_speechReady) {
        if (!mounted) return;
        showSnackBar(context, l10n.voiceLogUnavailable);
        return;
      }
    }

    final localeId = _matchLocale(langCode);
    setState(() {
      _recording = true;
      _hasResult = false;
      _transcript = '';
      _elapsedSeconds = 0;
    });
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _elapsedSeconds++);
    });

    await _speech.listen(
      onResult: _onResult,
      listenOptions: SpeechListenOptions(
        localeId: localeId,
        partialResults: true,
        cancelOnError: true,
        listenMode: ListenMode.dictation,
        listenFor: const Duration(seconds: 60),
        pauseFor: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _stop() async {
    await _speech.stop();
    _finishListening();
  }

  void _onResult(SpeechRecognitionResult result) {
    if (!mounted) return;
    setState(() => _transcript = result.recognizedWords);
  }

  void _onSpeechStatus(String status) {
    if (!mounted || !_recording) return;
    if (status == SpeechToText.notListeningStatus ||
        status == SpeechToText.doneStatus) {
      _finishListening();
    }
  }

  void _onSpeechError(SpeechRecognitionError error) {
    if (!mounted || !_recording) return;
    _ticker?.cancel();
    final transcript = _transcript.trim();
    setState(() {
      _recording = false;
      _hasResult = transcript.isNotEmpty;
      if (transcript.isNotEmpty) _applyResult(transcript);
    });
    showSnackBar(context, AppLocalizations.of(context).voiceLogError);
  }

  /// Kết thúc phiên nghe bình thường (tap dừng / im lặng / hết giờ).
  void _finishListening() {
    if (!_recording) return; // đã xử lý bởi error → bỏ qua callback trùng
    _ticker?.cancel();
    if (!mounted) return;
    final transcript = _transcript.trim();
    if (transcript.isEmpty) {
      setState(() {
        _recording = false;
        _hasResult = false;
      });
      showSnackBar(context, AppLocalizations.of(context).voiceLogNoSpeech);
      return;
    }
    setState(() {
      _recording = false;
      _hasResult = true;
      _applyResult(transcript);
    });
  }

  /// Parse cục bộ (tức thì) → đổ vào state có thể chỉnh.
  void _applyResult(String transcript) {
    final parsed = _parseService.parse(
      transcript: transcript,
      localeCode: Localizations.localeOf(context).languageCode,
    );
    _nameController.text = parsed.name;
    _tier = parsed.tier;
    _duration = parsed.durationMinutes;
    _mood = parsed.mood;
  }

  void _save() {
    final l10n = AppLocalizations.of(context);
    final name = _nameController.text.trim().isEmpty
        ? l10n.voiceLogMockActivity
        : _nameController.text.trim();
    context.read<ActivityBloc>().add(
          ActivityLogRequested(
            name: name,
            tier: _tier,
            durationMinutes: _duration,
            mood: _mood,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.x, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.voiceLogTitle),
      ),
      body: BlocListener<ActivityBloc, ActivityState>(
        listener: (context, state) {
          if (state is ActivityLogSuccess) {
            Navigator.pop(context);
          } else if (state is ActivityFailure) {
            showSnackBar(context, state.message);
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.space5),
                  children: [
                    const SizedBox(height: AppSpacing.space5),
                    _MicCircle(
                      recording: _recording,
                      waveController: _waveController,
                      onTap: _toggle,
                    ),
                    const SizedBox(height: AppSpacing.space5),
                    Center(
                      child: Text(
                        _statusLabel(context),
                        style: AppTextStyles.heading2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space2),
                    Center(
                      child: Text(
                        _statusSubLabel(context),
                        style: AppTextStyles.caption,
                      ),
                    ),
                    if (_transcript.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.space6),
                      _TranscriptCard(text: _transcript),
                    ],
                    if (_hasResult) ...[
                      const SizedBox(height: AppSpacing.space4),
                      _ResultEditor(
                        nameController: _nameController,
                        tier: _tier,
                        durationMinutes: _duration,
                        mood: _mood,
                        onTier: (t) => setState(() => _tier = t),
                        onDuration: (m) => setState(() => _duration = m),
                        onMood: (e) => setState(() => _mood = e),
                      ),
                    ],
                  ],
                ),
              ),
              if (_hasResult)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.space5,
                    0,
                    AppSpacing.space5,
                    AppSpacing.space5,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: l10n.voiceLogReRecord,
                          variant: AppButtonVariant.secondary,
                          icon: LucideIcons.refreshCw,
                          onPressed: _start,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.space3),
                      Expanded(
                        child: AppButton(
                          label: l10n.voiceLogSave,
                          icon: LucideIcons.check,
                          onPressed: _save,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _statusLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_recording) {
      final mm = (_elapsedSeconds ~/ 60).toString().padLeft(1, '0');
      final ss = (_elapsedSeconds % 60).toString().padLeft(2, '0');
      return l10n.voiceLogListening('$mm:$ss');
    }
    if (_hasResult) return l10n.voiceLogDone;
    return l10n.voiceLogTapToStart;
  }

  String _statusSubLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_recording) return l10n.voiceLogTapToStop;
    if (_hasResult) return l10n.voiceLogReviewSubtitle;
    return l10n.voiceLogExample;
  }
}

// ============================ Mic circle ============================

class _MicCircle extends StatelessWidget {
  final bool recording;
  final AnimationController waveController;
  final VoidCallback onTap;

  const _MicCircle({
    required this.recording,
    required this.waveController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (recording)
              ..._buildPulseRings()
            else
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: AppColors.brandPrimaryBg,
                  shape: BoxShape.circle,
                ),
              ),
            Material(
              color: AppColors.brandPrimary,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onTap,
                child: SizedBox(
                  width: 112,
                  height: 112,
                  child: Icon(
                    recording ? LucideIcons.square : LucideIcons.mic,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPulseRings() {
    return List.generate(3, (i) {
      return AnimatedBuilder(
        animation: waveController,
        builder: (_, __) {
          final t = ((waveController.value + i * 0.33) % 1.0);
          final eased = Curves.easeOut.transform(t);
          final size = 112 + (88 * eased);
          final alpha = (1 - eased) * 0.35;
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.brandPrimary.withValues(alpha: alpha),
              shape: BoxShape.circle,
            ),
          );
        },
      );
    });
  }
}

// ============================ Transcript card ============================

class _TranscriptCard extends StatelessWidget {
  final String text;
  const _TranscriptCard({required this.text});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.lgR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.voiceLogTranscriptLabel,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            '"$text"',
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
              height: 1.55,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================ Result editor ============================

String _tierDot(DopamineTier t) => switch (t) {
      DopamineTier.cheap => '🔴',
      DopamineTier.medium => '🟡',
      DopamineTier.healthy => '🟢',
      DopamineTier.deep => '🔵',
    };

/// Thẻ kết quả CÓ THỂ SỬA: tên (TextField), tier / thời lượng / mood (chips).
class _ResultEditor extends StatelessWidget {
  final TextEditingController nameController;
  final DopamineTier tier;
  final int durationMinutes;
  final String mood;
  final ValueChanged<DopamineTier> onTier;
  final ValueChanged<int> onDuration;
  final ValueChanged<String> onMood;

  const _ResultEditor({
    required this.nameController,
    required this.tier,
    required this.durationMinutes,
    required this.mood,
    required this.onTier,
    required this.onDuration,
    required this.onMood,
  });

  static const _durationOptions = [5, 15, 30, 45, 60, 90, 120];
  static const _moodOptions = ['😄', '😊', '🙂', '😐', '😞'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.lgR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.pencil,
                  size: 14, color: AppColors.brandPrimary),
              const SizedBox(width: AppSpacing.space1),
              Text(
                l10n.voiceLogReviewLabel,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.brandPrimary,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space4),

          // Tên
          _FieldLabel(l10n.voiceLogNameLabel),
          const SizedBox(height: AppSpacing.space2),
          TextField(
            controller: nameController,
            style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: AppColors.surface2,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space3,
                vertical: AppSpacing.space3,
              ),
              border: OutlineInputBorder(
                borderRadius: AppRadius.smR,
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space4),

          // Tier
          _FieldLabel(l10n.voiceLogTierLabel),
          const SizedBox(height: AppSpacing.space2),
          Wrap(
            spacing: AppSpacing.space2,
            runSpacing: AppSpacing.space2,
            children: DopamineTier.values
                .map((t) => _SelectChip(
                      text: '${_tierDot(t)} ${t.label(context)}',
                      selected: t == tier,
                      selectedColor: t.main,
                      unselectedBg: t.bg,
                      unselectedFg: t.textColor,
                      onTap: () => onTier(t),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppSpacing.space4),

          // Thời lượng — nút −/＋ bước 5 phút + giá trị hiện tại
          Row(
            children: [
              _FieldLabel(l10n.voiceLogDurationLabel),
              const Spacer(),
              _StepButton(
                icon: LucideIcons.minus,
                onTap: durationMinutes <= 0
                    ? null
                    : () => onDuration((durationMinutes - 5).clamp(0, 600)),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 64),
                child: Text(
                  formatMinutes(context, durationMinutes),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textPrimary),
                ),
              ),
              _StepButton(
                icon: LucideIcons.plus,
                onTap: () => onDuration((durationMinutes + 5).clamp(0, 600)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space2),
          Wrap(
            spacing: AppSpacing.space2,
            runSpacing: AppSpacing.space2,
            children: _durationOptions
                .map((m) => _SelectChip(
                      text: formatMinutes(context, m),
                      selected: m == durationMinutes,
                      selectedColor: AppColors.brandPrimary,
                      unselectedBg: AppColors.surface2,
                      unselectedFg: AppColors.textPrimary,
                      onTap: () => onDuration(m),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppSpacing.space4),

          // Cảm xúc
          _FieldLabel(l10n.voiceLogMoodLabel),
          const SizedBox(height: AppSpacing.space2),
          Wrap(
            spacing: AppSpacing.space2,
            children: _moodOptions
                .map((e) => _MoodChip(
                      emoji: e,
                      selected: e == mood,
                      onTap: () => onMood(e),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.label.copyWith(
        color: AppColors.textTertiary,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _SelectChip extends StatelessWidget {
  final String text;
  final bool selected;
  final Color selectedColor;
  final Color unselectedBg;
  final Color unselectedFg;
  final VoidCallback onTap;

  const _SelectChip({
    required this.text,
    required this.selected,
    required this.selectedColor,
    required this.unselectedBg,
    required this.unselectedFg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? selectedColor : unselectedBg,
      borderRadius: AppRadius.mdR,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdR,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space3,
            vertical: AppSpacing.space2,
          ),
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: selected ? Colors.white : unselectedFg,
            ),
          ),
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Material(
      color: AppColors.surface2,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 34,
          height: 34,
          child: Icon(
            icon,
            size: 16,
            color: enabled ? AppColors.textPrimary : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }
}

class _MoodChip extends StatelessWidget {
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _MoodChip({
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: selected ? AppColors.brandPrimaryBg : AppColors.surface2,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.brandPrimary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20))),
      ),
    );
  }
}
