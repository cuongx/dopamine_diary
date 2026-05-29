import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Logo app render bằng code — vòng tròn gradient brand + icon sparkles + text.
/// Không cần file ảnh. Scale vô hạn theo `size`.
class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;

  const AppLogo({
    super.key,
    this.size = 40,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.brandPrimaryText,
                AppColors.brandPrimary,
              ],
            ),
          ),
          child: Icon(
            LucideIcons.sparkles,
            size: size * 0.5,
            color: Colors.white,
          ),
        ),
        if (showText) ...[
          const SizedBox(width: AppSpacing.space3),
          Text('Dopamine Diary', style: AppTextStyles.heading2),
        ],
      ],
    );
  }
}
