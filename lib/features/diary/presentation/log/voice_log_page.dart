import 'dart:async';

import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/core/utils/show_snackbar.dart';
import 'package:dopamine_diary/features/diary/presentation/log/bloc/activity_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Voice Log — UI mock (chưa wire STT thật).
/// Flow: tap mic để bắt đầu "ghi" → timer chạy + waveform → tap lại để dừng →
/// transcript + AI parsed chips → Sửa / Lưu (Lưu sẽ log activity mock).
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
  bool _recording = false;
  bool _hasResult = false;
  int _elapsedSeconds = 0;
  Timer? _ticker;
  late final AnimationController _waveController;

  // Mock data sau khi "nghe xong".
  static const DopamineTier _mockTier = DopamineTier.healthy;
  static const int _mockDurationMinutes = 30;
  static const String _mockMood = '😊';

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _waveController.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_recording) {
      _stop();
    } else {
      _start();
    }
  }

  void _start() {
    setState(() {
      _recording = true;
      _hasResult = false;
      _elapsedSeconds = 0;
    });
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _elapsedSeconds++);
      // Tự dừng sau 8s để cảm giác như STT trả kết quả.
      if (_elapsedSeconds >= 8) _stop();
    });
  }

  void _stop() {
    _ticker?.cancel();
    setState(() {
      _recording = false;
      _hasResult = true;
    });
  }

  void _save() {
    final l10n = AppLocalizations.of(context);
    context.read<ActivityBloc>().add(
          ActivityLogRequested(
            name: l10n.voiceLogMockActivity,
            tier: _mockTier,
            durationMinutes: _mockDurationMinutes,
            mood: _mockMood,
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
                    if (_hasResult) ...[
                      const SizedBox(height: AppSpacing.space6),
                      _TranscriptCard(text: l10n.voiceLogMockTranscript),
                      const SizedBox(height: AppSpacing.space4),
                      _ParsedCard(
                        activityName: l10n.voiceLogMockActivity,
                        tier: _mockTier,
                        durationMinutes: _mockDurationMinutes,
                        mood: _mockMood,
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

// ============================ Parsed card ============================

class _ParsedCard extends StatelessWidget {
  final String activityName;
  final DopamineTier tier;
  final int durationMinutes;
  final String mood;

  const _ParsedCard({
    required this.activityName,
    required this.tier,
    required this.durationMinutes,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.brandPrimaryBg,
        borderRadius: AppRadius.lgR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.sparkles,
                  size: 14, color: AppColors.brandPrimary),
              const SizedBox(width: AppSpacing.space1),
              Text(
                l10n.voiceLogAiUnderstoodLabel,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.brandPrimary,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space3),
          Wrap(
            spacing: AppSpacing.space2,
            runSpacing: AppSpacing.space2,
            children: [
              _ParsedChip(
                color: tier.main,
                text: '${_dotEmoji(tier)} $activityName',
              ),
              _ParsedChip(
                color: AppColors.brandPrimary,
                text: l10n.minutesValue(durationMinutes),
              ),
              _ParsedChip(
                color: AppColors.brandPrimary,
                text: l10n.voiceLogMoodChip(mood),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _dotEmoji(DopamineTier t) => switch (t) {
        DopamineTier.cheap => '🔴',
        DopamineTier.medium => '🟡',
        DopamineTier.healthy => '🟢',
        DopamineTier.deep => '🔵',
      };
}

class _ParsedChip extends StatelessWidget {
  final Color color;
  final String text;

  const _ParsedChip({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space3,
        vertical: AppSpacing.space1 + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.smR,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyMedium.copyWith(color: color),
      ),
    );
  }
}
