import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum InsightVariant {
  /// Nền tím nhạt brandPrimaryBg, icon sparkles — gợi ý AI.
  ai,

  /// Nền teal nhạt accentCalmBg, icon trendingUp — pattern phát hiện.
  pattern,
}

/// Card hiển thị insight ở màn Analytics.
class InsightCard extends StatelessWidget {
  final InsightVariant variant;
  final String title;
  final String description;

  const InsightCard({
    super.key,
    required this.variant,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final config = _configOf(variant);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: config.bg,
        borderRadius: AppRadius.lgR,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: config.iconBg,
              borderRadius: AppRadius.smR,
            ),
            child: Icon(config.icon, size: 18, color: config.iconColor),
          ),
          const SizedBox(width: AppSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  config.label,
                  style: AppTextStyles.label.copyWith(color: config.iconColor),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: config.textColor),
                ),
                const SizedBox(height: AppSpacing.space1),
                Text(
                  description,
                  style: AppTextStyles.caption
                      .copyWith(color: config.textColor.withValues(alpha: 0.75)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _InsightConfig _configOf(InsightVariant variant) {
    return switch (variant) {
      InsightVariant.ai => const _InsightConfig(
          bg: AppColors.brandPrimaryBg,
          iconBg: Color(0xFFDDD9FB),
          iconColor: AppColors.brandPrimary,
          textColor: AppColors.brandPrimaryText,
          icon: LucideIcons.sparkles,
          label: 'AI GỢI Ý',
        ),
      InsightVariant.pattern => const _InsightConfig(
          bg: AppColors.accentCalmBg,
          iconBg: Color(0xFFCCEDDE),
          iconColor: AppColors.accentCalm,
          textColor: AppColors.accentCalmText,
          icon: LucideIcons.trendingUp,
          label: 'PATTERN',
        ),
    };
  }
}

class _InsightConfig {
  final Color bg;
  final Color iconBg;
  final Color iconColor;
  final Color textColor;
  final IconData icon;
  final String label;

  const _InsightConfig({
    required this.bg,
    required this.iconBg,
    required this.iconColor,
    required this.textColor,
    required this.icon,
    required this.label,
  });
}
