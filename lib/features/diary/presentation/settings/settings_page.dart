import 'package:dopamine_diary/core/common/cubits/locale/locale_cubit.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/core/utils/show_snackbar.dart';
import 'package:dopamine_diary/features/diary/presentation/buddy/buddy_page.dart';
import 'package:dopamine_diary/features/diary/presentation/onboarding/onboarding_page.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Settings — profile, tier setup, buddy, threshold, blocked apps, language.
/// Threshold slider chỉ là UI mock (chưa wire vào logic chặn).
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _cheapLimitHours = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space5,
          AppSpacing.space3,
          AppSpacing.space5,
          AppSpacing.space10,
        ),
        children: [
          const _ProfileCard(),
          const SizedBox(height: AppSpacing.space5),

          _SectionLabel(l10n.settingsSectionCustomize),
          const SizedBox(height: AppSpacing.space2),
          _Tile(
            icon: LucideIcons.layers,
            title: l10n.settingsTileTierClassification,
            subtitle: l10n.settingsTileTierClassificationSub,
            onTap: () =>
                Navigator.push(context, OnboardingPage.route()),
          ),
          _Tile(
            icon: LucideIcons.users,
            title: l10n.settingsTileBuddy,
            subtitle: l10n.settingsTileBuddySub,
            onTap: () => Navigator.push(context, BuddyPage.route()),
          ),

          const SizedBox(height: AppSpacing.space5),
          _SectionLabel(l10n.settingsSectionLanguage),
          const SizedBox(height: AppSpacing.space2),
          const _LanguageCard(),

          const SizedBox(height: AppSpacing.space5),
          _SectionLabel(l10n.settingsSectionThreshold),
          const SizedBox(height: AppSpacing.space2),
          _ThresholdCard(
            value: _cheapLimitHours,
            onChanged: (v) => setState(() => _cheapLimitHours = v),
          ),

          const SizedBox(height: AppSpacing.space5),
          _SectionLabel(l10n.settingsSectionBlockedApps),
          const SizedBox(height: AppSpacing.space2),
          const _BlockedAppsCard(),

          const SizedBox(height: AppSpacing.space5),
          _SectionLabel(l10n.settingsSectionAbout),
          const SizedBox(height: AppSpacing.space2),
          _Tile(
            icon: LucideIcons.shield,
            title: l10n.settingsTilePrivacy,
            subtitle: l10n.settingsTilePrivacySub,
            onTap: () => showSnackBar(context, l10n.settingsPrivacySnackbar),
          ),
          _Tile(
            icon: LucideIcons.info,
            title: l10n.settingsTileAbout,
            subtitle: l10n.settingsTileAboutSub,
            onTap: () => showSnackBar(context, l10n.settingsAboutSnackbar),
          ),
        ],
      ),
    );
  }
}

// ============================ Subcomponents ============================

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

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
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.brandPrimary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                l10n.settingsProfileName.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.settingsProfileName,
                    style: AppTextStyles.heading2),
                const SizedBox(height: 2),
                Text(
                  l10n.settingsProfileMemberSince,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.label.copyWith(
        color: AppColors.textTertiary,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space2),
      child: Material(
        color: AppColors.surface1,
        borderRadius: AppRadius.mdR,
        child: InkWell(
          borderRadius: AppRadius.mdR,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.space3),
            decoration: BoxDecoration(
              borderRadius: AppRadius.mdR,
              border: Border.all(color: AppColors.borderSubtle, width: 0.5),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: AppRadius.smR,
                  ),
                  child: Icon(icon, size: 18, color: AppColors.textPrimary),
                ),
                const SizedBox(width: AppSpacing.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.bodyMedium),
                      const SizedBox(height: 2),
                      Text(subtitle, style: AppTextStyles.caption),
                    ],
                  ),
                ),
                const Icon(
                  LucideIcons.chevronRight,
                  size: 18,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.watch<LocaleCubit>();
    final current = cubit.state?.languageCode; // null → system
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space3),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.mdR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        children: [
          _LanguageRow(
            label: l10n.settingsLanguageSystem,
            selected: current == null,
            onTap: () => context.read<LocaleCubit>().setLocale(null),
          ),
          const _LangDivider(),
          _LanguageRow(
            label: l10n.settingsLanguageVietnamese,
            selected: current == 'vi',
            onTap: () => context.read<LocaleCubit>().setLocale('vi'),
          ),
          const _LangDivider(),
          _LanguageRow(
            label: l10n.settingsLanguageEnglish,
            selected: current == 'en',
            onTap: () => context.read<LocaleCubit>().setLocale('en'),
          ),
        ],
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.smR,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.space2),
        child: Row(
          children: [
            Expanded(child: Text(label, style: AppTextStyles.body)),
            if (selected)
              const Icon(LucideIcons.check,
                  size: 18, color: AppColors.brandPrimary),
          ],
        ),
      ),
    );
  }
}

class _LangDivider extends StatelessWidget {
  const _LangDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.5,
      thickness: 0.5,
      color: AppColors.borderSubtle,
    );
  }
}

class _ThresholdCard extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _ThresholdCard({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formatted = value.toStringAsFixed(1);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.settingsThresholdLabel,
                style: AppTextStyles.bodyMedium,
              ),
              Text(
                l10n.settingsThresholdValue(formatted),
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.brandPrimary),
              ),
            ],
          ),
          Slider(
            value: value,
            min: 0.5,
            max: 4,
            divisions: 7,
            label: l10n.settingsThresholdValue(formatted),
            onChanged: onChanged,
          ),
          Text(
            l10n.settingsThresholdDesc,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}

class _BlockedAppsCard extends StatelessWidget {
  const _BlockedAppsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space3),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.mdR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: const Column(
        children: [
          _BlockedAppRow(name: 'TikTok', enabled: true),
          _Divider(),
          _BlockedAppRow(name: 'Instagram', enabled: true),
          _Divider(),
          _BlockedAppRow(name: 'YouTube Shorts', enabled: true),
          _Divider(),
          _BlockedAppRow(name: 'Facebook', enabled: false),
        ],
      ),
    );
  }
}

class _BlockedAppRow extends StatefulWidget {
  final String name;
  final bool enabled;

  const _BlockedAppRow({required this.name, required this.enabled});

  @override
  State<_BlockedAppRow> createState() => _BlockedAppRowState();
}

class _BlockedAppRowState extends State<_BlockedAppRow> {
  late bool _on = widget.enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space2),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _on ? AppColors.cheapBg : AppColors.surface2,
              borderRadius: AppRadius.smR,
            ),
            child: Icon(
              _on ? LucideIcons.ban : LucideIcons.circle,
              size: 16,
              color: _on ? AppColors.cheapFg : AppColors.textTertiary,
            ),
          ),
          const SizedBox(width: AppSpacing.space3),
          Expanded(child: Text(widget.name, style: AppTextStyles.body)),
          Switch.adaptive(
            value: _on,
            onChanged: (v) => setState(() => _on = v),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.5,
      thickness: 0.5,
      color: AppColors.borderSubtle,
    );
  }
}
