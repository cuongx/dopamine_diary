import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

/// Placeholder Home tạm cho giai đoạn build.
/// Sẽ bị thay thế ở Phase 6 bằng HomePage (Home Dashboard thật).
class BootstrapPlaceholder extends StatelessWidget {
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => const BootstrapPlaceholder(),
      );

  const BootstrapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dopamine Diary')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đang trong giai đoạn xây dựng',
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: AppSpacing.space2),
              Text(
                'Home Dashboard sẽ xuất hiện sau khi Phase 6 hoàn tất.',
                style: AppTextStyles.body
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
