import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/l10n/tier_labels.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Thanh ngang chia 4 đoạn theo tỉ lệ thời gian mỗi tier.
/// Hiển thị legend (4 chip) bên dưới nếu `showLegend = true`.
///
/// Phase 9 sẽ thêm staggered fill animation (50ms delay mỗi tier).
class TierBar extends StatelessWidget {
  /// Phần trăm 0.0-1.0 cho mỗi tier. Có thể tổng không bằng 1 nếu tier vắng.
  final Map<DopamineTier, double> percentByTier;
  final double height;
  final bool showLegend;

  const TierBar({
    super.key,
    required this.percentByTier,
    this.height = 12,
    this.showLegend = true,
  });

  @override
  Widget build(BuildContext context) {
    final visibleTiers = DopamineTier.values
        .where((t) => (percentByTier[t] ?? 0) > 0)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: AppRadius.smR,
            child: visibleTiers.isEmpty
                ? Container(color: AppColors.surface2)
                : Row(
                    children: [
                      for (final tier in visibleTiers)
                        Expanded(
                          flex: (percentByTier[tier]! * 1000).round(),
                          child: Container(color: tier.main),
                        ),
                    ],
                  ),
          ),
        ),
        if (showLegend) ...[
          const SizedBox(height: AppSpacing.space3),
          Wrap(
            spacing: AppSpacing.space3,
            runSpacing: AppSpacing.space2,
            children: DopamineTier.values.map((tier) {
              final pct = ((percentByTier[tier] ?? 0) * 100).round();
              return _LegendChip(tier: tier, percent: pct);
            }).toList(),
          ),
        ],
      ],
    );
  }
}

class _LegendChip extends StatelessWidget {
  final DopamineTier tier;
  final int percent;

  const _LegendChip({required this.tier, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: tier.main,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '${tier.label(context)} $percent%',
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
