import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

/// Empty state — icon mờ + title + description + CTA optional.
/// Tone empathetic, KHÔNG phán xét: "Chưa có hoạt động nào" thay vì "Không có gì!"
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? ctaLabel;
  final VoidCallback? onCtaPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.ctaLabel,
    this.onCtaPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space6,
          vertical: AppSpacing.space5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.surface2,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(
              title,
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.space2),
            Text(
              description,
              style: AppTextStyles.body
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (ctaLabel != null && onCtaPressed != null) ...[
              const SizedBox(height: AppSpacing.space5),
              AppButton(
                label: ctaLabel!,
                onPressed: onCtaPressed,
                variant: AppButtonVariant.secondary,
                fullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
