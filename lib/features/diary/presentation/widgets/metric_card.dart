import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Card thống kê đơn lẻ — label (11/400 muted) + value (24/500) + delta optional.
///
/// Dùng ở Analytics: "Dopamine rẻ 12h30p" + "Deep work 8h15p".
class MetricCard extends StatelessWidget {
  final String label;
  final String value;

  /// Delta dạng "+12%" hoặc "-3h" — null nếu không hiển thị.
  /// `deltaIsPositive` quyết định màu (xanh/đỏ nhạt).
  final String? delta;
  final bool deltaIsPositive;
  final IconData? icon;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    this.delta,
    this.deltaIsPositive = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.lgR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: AppColors.textTertiary),
                const SizedBox(width: AppSpacing.space1),
              ],
              Expanded(
                child: Text(
                  label.toUpperCase(),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textTertiary,
                    letterSpacing: 0.8,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              height: 1.1,
              letterSpacing: -0.3,
            ),
          ),
          if (delta != null) ...[
            const SizedBox(height: AppSpacing.space1),
            Row(
              children: [
                Icon(
                  deltaIsPositive
                      ? LucideIcons.trendingUp
                      : LucideIcons.trendingDown,
                  size: 12,
                  color: deltaIsPositive
                      ? AppColors.healthyFg
                      : AppColors.cheapFg,
                ),
                const SizedBox(width: 4),
                Text(
                  delta!,
                  style: AppTextStyles.label.copyWith(
                    color: deltaIsPositive
                        ? AppColors.healthyFg
                        : AppColors.cheapFg,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
