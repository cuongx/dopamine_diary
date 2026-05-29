import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/core/utils/show_snackbar.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Buddy — accountability partner. UI mock (chưa có backend social).
/// Trọng tâm support, KHÔNG thi đua: hai cột điểm chỉ để cùng nhìn,
/// không bảng xếp hạng.
class BuddyPage extends StatelessWidget {
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => const BuddyPage(),
      );

  const BuddyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.buddyTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space5,
          AppSpacing.space3,
          AppSpacing.space5,
          AppSpacing.space10,
        ),
        children: [
          _BuddyCard(
            name: l10n.buddyMockName,
            status: l10n.buddyOnlineStatus,
          ),
          const SizedBox(height: AppSpacing.space4),
          const _ScoreCompareCard(yourScore: 72, buddyScore: 68),
          const SizedBox(height: AppSpacing.space5),
          Text(
            l10n.buddyFeedSection,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),
          _FeedItem(
            icon: LucideIcons.footprints,
            text: l10n.buddyFeedRun,
            time: l10n.buddyTimeMinutesAgo(20),
            tone: _FeedTone.healthy,
          ),
          _FeedItem(
            icon: LucideIcons.bookOpen,
            text: l10n.buddyFeedRead,
            time: l10n.buddyTimeHoursAgo(1),
            tone: _FeedTone.deep,
          ),
          _FeedItem(
            icon: LucideIcons.alertCircle,
            text: l10n.buddyFeedNeedSupport,
            time: l10n.buddyTimeHoursAgo(2),
            tone: _FeedTone.warning,
          ),
          const SizedBox(height: AppSpacing.space5),
          AppButton(
            label: l10n.buddySendEncouragement,
            icon: LucideIcons.heart,
            variant: AppButtonVariant.tertiary,
            onPressed: () => _sendEncouragement(context),
          ),
          const SizedBox(height: AppSpacing.space3),
          AppButton(
            label: l10n.buddyInviteCta,
            icon: LucideIcons.userPlus,
            variant: AppButtonVariant.secondary,
            onPressed: () =>
                showSnackBar(context, l10n.buddyInviteUnavailable),
          ),
        ],
      ),
    );
  }

  void _sendEncouragement(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface1,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (_) => const _EncouragementSheet(),
    );
  }
}

// ============================ Buddy card ============================

class _BuddyCard extends StatelessWidget {
  final String name;
  final String status;
  const _BuddyCard({required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.accentCalmBg,
        borderRadius: AppRadius.lgR,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.accentCalm,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name.substring(0, 1),
                style: AppTextStyles.heading2.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.heading2
                      .copyWith(color: AppColors.accentCalmText),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.healthyMain,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space1),
                    Expanded(
                      child: Text(
                        status,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.accentCalm,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================ Score compare ============================

class _ScoreCompareCard extends StatelessWidget {
  final int yourScore;
  final int buddyScore;
  const _ScoreCompareCard({
    required this.yourScore,
    required this.buddyScore,
  });

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
            l10n.buddyTodayLabel,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),
          Row(
            children: [
              Expanded(
                child: _ScoreColumn(
                  label: l10n.buddyYourScoreLabel,
                  score: yourScore,
                  color: AppColors.deepMain,
                ),
              ),
              Container(
                width: 0.5,
                height: 56,
                color: AppColors.borderSubtle,
              ),
              Expanded(
                child: _ScoreColumn(
                  label: l10n.buddyMockName,
                  score: buddyScore,
                  color: AppColors.accentCalm,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space3),
          Container(
            padding: const EdgeInsets.all(AppSpacing.space3),
            decoration: BoxDecoration(
              color: AppColors.brandPrimaryBg,
              borderRadius: AppRadius.smR,
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.heart,
                    size: 14, color: AppColors.brandPrimary),
                const SizedBox(width: AppSpacing.space2),
                Expanded(
                  child: Text(
                    l10n.buddyNotCompetitionNote,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.brandPrimary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreColumn extends StatelessWidget {
  final String label;
  final int score;
  final Color color;

  const _ScoreColumn({
    required this.label,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.space1),
        Text(
          '$score',
          style: AppTextStyles.display
              .copyWith(fontSize: 36, color: color, height: 1),
        ),
      ],
    );
  }
}

// ============================ Feed ============================

enum _FeedTone { healthy, deep, warning }

class _FeedItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String time;
  final _FeedTone tone;

  const _FeedItem({
    required this.icon,
    required this.text,
    required this.time,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      _FeedTone.healthy => (AppColors.healthyBg, AppColors.healthyFg),
      _FeedTone.deep => (AppColors.deepBg, AppColors.deepFg),
      _FeedTone.warning => (AppColors.mediumBg, AppColors.mediumFg),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space2),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space3),
        decoration: BoxDecoration(
          color: AppColors.surface1,
          borderRadius: AppRadius.mdR,
          border: Border.all(color: AppColors.borderSubtle, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: AppRadius.smR,
              ),
              child: Icon(icon, size: 18, color: fg),
            ),
            const SizedBox(width: AppSpacing.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 2),
                  Text(time, style: AppTextStyles.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================ Encouragement sheet ============================

class _EncouragementSheet extends StatelessWidget {
  const _EncouragementSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final messages = [
      l10n.buddyMessage1,
      l10n.buddyMessage2,
      l10n.buddyMessage3,
      l10n.buddyMessage4,
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderDefault,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(l10n.buddySheetTitle, style: AppTextStyles.heading2),
            const SizedBox(height: AppSpacing.space1),
            Text(
              l10n.buddySheetSubtitle,
              style: AppTextStyles.body
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space4),
            ...messages.map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.space2),
                child: Material(
                  color: AppColors.brandPrimaryBg,
                  borderRadius: AppRadius.mdR,
                  child: InkWell(
                    borderRadius: AppRadius.mdR,
                    onTap: () {
                      Navigator.pop(context);
                      showSnackBar(context, l10n.buddyMessageSent);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.space3),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.send,
                              size: 16, color: AppColors.brandPrimary),
                          const SizedBox(width: AppSpacing.space2),
                          Expanded(
                            child: Text(
                              m,
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.brandPrimaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space2),
          ],
        ),
      ),
    );
  }
}
