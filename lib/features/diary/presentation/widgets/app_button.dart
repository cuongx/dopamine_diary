import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant {
  /// Đen, chữ trắng — nút primary (Ghi nhanh, Bắt đầu detox…).
  primary,

  /// Border 0.5px, chữ đen — nút secondary (Hủy, Sửa…).
  secondary,

  /// Nền tím nhạt brandPrimaryBg, chữ brand — nút detox/AI/premium.
  tertiary,

  /// Chỉ chữ, không border — link / huỷ nhẹ.
  ghost,
}

/// Button thống nhất cho toàn app. Height 44, radius 8 theo design tokens.
///
/// Variant `primary/secondary/ghost` dùng theme buttons có sẵn ở `theme.dart`,
/// `tertiary` custom với màu brand.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool fullWidth;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.fullWidth = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;
    final child = isLoading
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: AppSpacing.space2),
              ],
              Flexible(
                child: Text(label, overflow: TextOverflow.ellipsis),
              ),
            ],
          );

    final button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
          onPressed: disabled ? null : onPressed,
          child: child,
        ),
      AppButtonVariant.secondary => OutlinedButton(
          onPressed: disabled ? null : onPressed,
          child: child,
        ),
      AppButtonVariant.tertiary => ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brandPrimaryBg,
            foregroundColor: AppColors.brandPrimaryText,
            elevation: 0,
            minimumSize: const Size(0, 44),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.mdR),
            textStyle: AppTextStyles.bodyMedium,
          ),
          child: child,
        ),
      AppButtonVariant.ghost => TextButton(
          onPressed: disabled ? null : onPressed,
          child: child,
        ),
    };

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
