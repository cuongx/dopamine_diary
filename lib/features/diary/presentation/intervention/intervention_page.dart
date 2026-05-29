import 'dart:async';

import 'package:dopamine_diary/core/l10n/duration_format.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Suggestion thay thế cho dopamine rẻ — render trong InterventionPage.
class InterventionSuggestion {
  final IconData icon;

  /// Builder để label theo locale.
  final String Function(AppLocalizations l10n) titleBuilder;
  final String Function(AppLocalizations l10n) durationBuilder;

  const InterventionSuggestion({
    required this.icon,
    required this.titleBuilder,
    required this.durationBuilder,
  });
}

/// Intervention popup: hiện khi user định mở app cheap (TikTok, Reels...).
/// Tone đồng cảm — KHÔNG hard-block, có escape hatch countdown 20s.
class InterventionPage extends StatefulWidget {
  static MaterialPageRoute<bool> route({
    required String appName,
    required int usedMinutesToday,
    required int limitMinutesToday,
  }) =>
      MaterialPageRoute<bool>(
        builder: (_) => InterventionPage(
          appName: appName,
          usedMinutesToday: usedMinutesToday,
          limitMinutesToday: limitMinutesToday,
        ),
        fullscreenDialog: true,
      );

  /// Tên app bị chặn (vd "TikTok").
  final String appName;

  /// Số phút đã dùng hôm nay.
  final int usedMinutesToday;

  /// Giới hạn user đặt ra cho hôm nay.
  final int limitMinutesToday;

  final List<InterventionSuggestion> suggestions;

  const InterventionPage({
    super.key,
    required this.appName,
    required this.usedMinutesToday,
    required this.limitMinutesToday,
    this.suggestions = const [
      InterventionSuggestion(
        icon: LucideIcons.footprints,
        titleBuilder: _walkTitle,
        durationBuilder: _walkDuration,
      ),
      InterventionSuggestion(
        icon: LucideIcons.headphones,
        titleBuilder: _podcastTitle,
        durationBuilder: _podcastDuration,
      ),
      InterventionSuggestion(
        icon: LucideIcons.penTool,
        titleBuilder: _journalTitle,
        durationBuilder: _journalDuration,
      ),
    ],
  });

  static String _walkTitle(AppLocalizations l) =>
      l.interventionSuggestionWalkTitle;
  static String _walkDuration(AppLocalizations l) =>
      l.interventionSuggestionWalkDuration;
  static String _podcastTitle(AppLocalizations l) =>
      l.interventionSuggestionPodcastTitle;
  static String _podcastDuration(AppLocalizations l) =>
      l.interventionSuggestionPodcastDuration;
  static String _journalTitle(AppLocalizations l) =>
      l.interventionSuggestionJournalTitle;
  static String _journalDuration(AppLocalizations l) =>
      l.interventionSuggestionJournalDuration;

  @override
  State<InterventionPage> createState() => _InterventionPageState();
}

class _InterventionPageState extends State<InterventionPage> {
  Timer? _countdownTimer;
  int _remaining = 20;

  void _startCountdown() {
    if (_countdownTimer != null) return;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() => _remaining--);
      if (_remaining <= 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final progress =
        (widget.usedMinutesToday / widget.limitMinutesToday).clamp(0.0, 1.0);
    final ready = _remaining <= 0;

    return Scaffold(
      backgroundColor: AppColors.surface3,
      appBar: AppBar(
        backgroundColor: AppColors.surface3,
        leading: IconButton(
          icon: const Icon(LucideIcons.x, size: 22),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.interventionClose),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space5,
            AppSpacing.space2,
            AppSpacing.space5,
            AppSpacing.space5,
          ),
          children: [
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.mediumBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.hand,
                  size: 32,
                  color: AppColors.mediumFg,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              l10n.interventionTitle,
              style: AppTextStyles.display.copyWith(fontSize: 32),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.space2),
            Text(
              l10n.interventionSubtitle(widget.appName),
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.space5),

            // Stats card
            Container(
              padding: const EdgeInsets.all(AppSpacing.space4),
              decoration: BoxDecoration(
                color: AppColors.surface1,
                borderRadius: AppRadius.lgR,
                border:
                    Border.all(color: AppColors.borderSubtle, width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.interventionTodayLabel,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textTertiary,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        '${formatMinutes(context, widget.usedMinutesToday)} / ${formatMinutes(context, widget.limitMinutesToday)}',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space3),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: AppColors.surface2,
                      valueColor: AlwaysStoppedAnimation(
                        progress >= 1.0
                            ? AppColors.cheapMain
                            : AppColors.mediumMain,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.space5),
            Text(
              l10n.interventionTryLabel,
              style: AppTextStyles.label.copyWith(
                color: AppColors.textTertiary,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: AppSpacing.space3),
            ...widget.suggestions.map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.space2),
                child: _SuggestionRow(
                  suggestion: s,
                  onTap: () => Navigator.pop(context, false),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.space5),
            _EscapeHatch(
              remaining: _remaining,
              ready: ready,
              onArmed: _startCountdown,
              onProceed: () => Navigator.pop(context, true),
              appName: widget.appName,
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  final InterventionSuggestion suggestion;
  final VoidCallback onTap;

  const _SuggestionRow({required this.suggestion, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      color: AppColors.surface1,
      borderRadius: AppRadius.mdR,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdR,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.space3),
          decoration: BoxDecoration(
            borderRadius: AppRadius.mdR,
            border: Border.all(color: AppColors.borderSubtle, width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accentCalmBg,
                  borderRadius: AppRadius.smR,
                ),
                child: Icon(suggestion.icon,
                    size: 18, color: AppColors.accentCalm),
              ),
              const SizedBox(width: AppSpacing.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(suggestion.titleBuilder(l10n),
                        style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 2),
                    Text(suggestion.durationBuilder(l10n),
                        style: AppTextStyles.caption),
                  ],
                ),
              ),
              const Icon(
                LucideIcons.chevronRight,
                size: 18,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EscapeHatch extends StatelessWidget {
  final int remaining;
  final bool ready;
  final VoidCallback onArmed;
  final VoidCallback onProceed;
  final String appName;

  const _EscapeHatch({
    required this.remaining,
    required this.ready,
    required this.onArmed,
    required this.onProceed,
    required this.appName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (ready) {
      return AppButton(
        label: l10n.interventionOpenAnyway(appName),
        variant: AppButtonVariant.secondary,
        icon: LucideIcons.arrowRight,
        onPressed: onProceed,
      );
    }
    final armed = remaining < 20;
    return AppButton(
      label: armed
          ? l10n.interventionWaitSeconds(remaining)
          : l10n.interventionOpenAnywayWait(appName),
      variant: AppButtonVariant.ghost,
      onPressed: armed ? null : onArmed,
    );
  }
}
