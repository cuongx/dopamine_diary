import 'package:dopamine_diary/core/l10n/duration_format.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/lucide_icon_map.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Một dòng hoạt động đã log:
/// `[accent strip] [icon 36×36] [title + meta] [score chip]`.
///
/// `iconName` optional — fallback một icon mặc định theo tier nếu null.
/// Score chip màu xanh (positive) hoặc đỏ nhạt (negative), KHÔNG dùng red alert.
class ActivityRow extends StatelessWidget {
  final Activity activity;
  final String? iconName;
  final VoidCallback? onTap;

  const ActivityRow({
    super.key,
    required this.activity,
    this.iconName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tier = activity.tier;
    final timeStr = DateFormat('HH:mm').format(activity.timestamp);
    final durationStr = formatMinutes(context, activity.durationMinutes);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.mdR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.mdR,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Accent strip 3px màu tier
                Container(width: 3, color: tier.main),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space3,
                      vertical: AppSpacing.space3,
                    ),
                    child: Row(
                      children: [
                        // Icon 36×36
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: tier.bg,
                            borderRadius: AppRadius.smR,
                          ),
                          child: Icon(
                            LucideIconMap.of(iconName ?? 'sparkles'),
                            size: 18,
                            color: tier.fg,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space3),
                        // Title + meta
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                activity.name,
                                style: AppTextStyles.bodyMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$timeStr · $durationStr',
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space2),
                        // Score chip
                        _ScoreChip(impact: activity.scoreImpact),
                        if (activity.mood != null) ...[
                          const SizedBox(width: AppSpacing.space2),
                          Text(activity.mood!,
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class _ScoreChip extends StatelessWidget {
  final int impact;
  const _ScoreChip({required this.impact});

  @override
  Widget build(BuildContext context) {
    final positive = impact >= 0;
    final bg = positive ? AppColors.healthyBg : AppColors.cheapBg;
    final fg = positive ? AppColors.healthyFg : AppColors.cheapFg;
    final sign = positive ? '+' : '';
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space2,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.smR,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            positive ? LucideIcons.trendingUp : LucideIcons.trendingDown,
            size: 12,
            color: fg,
          ),
          const SizedBox(width: 2),
          Text(
            '$sign$impact',
            style: AppTextStyles.label.copyWith(color: fg),
          ),
        ],
      ),
    );
  }
}
