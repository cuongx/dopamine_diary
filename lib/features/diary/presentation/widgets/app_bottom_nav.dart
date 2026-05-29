import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Bottom nav 4 tab — flat, không shadow, border top 0.5px.
/// Tab active dùng `textPrimary`, inactive dùng `textTertiary`.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = <_NavItem>[
      _NavItem(icon: LucideIcons.home, label: l10n.navHome),
      _NavItem(icon: LucideIcons.barChart3, label: l10n.navAnalytics),
      _NavItem(icon: LucideIcons.zap, label: l10n.navDetox),
      _NavItem(icon: LucideIcons.user, label: l10n.navMe),
    ];
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface1,
        border: Border(
          top: BorderSide(color: AppColors.borderSubtle, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (i) {
              final active = i == currentIndex;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[i].icon,
                        size: 22,
                        color: active
                            ? AppColors.textPrimary
                            : AppColors.textTertiary,
                      ),
                      const SizedBox(height: AppSpacing.space1),
                      Text(
                        items[i].label,
                        style: AppTextStyles.caption.copyWith(
                          color: active
                              ? AppColors.textPrimary
                              : AppColors.textTertiary,
                          fontWeight:
                              active ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
