import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/core/utils/show_snackbar.dart';
import 'package:dopamine_diary/features/diary/presentation/detox/bloc/detox_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Detox setup wizard — chọn độ dài + độ nghiêm khắc + lý do + apps cần chặn.
/// Submit → DetoxBloc.start.
class DetoxSetupPage extends StatefulWidget {
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => const DetoxSetupPage(),
        fullscreenDialog: true,
      );

  const DetoxSetupPage({super.key});

  @override
  State<DetoxSetupPage> createState() => _DetoxSetupPageState();
}

class _DetoxSetupPageState extends State<DetoxSetupPage> {
  int _duration = 7;
  double _strictness = 2;
  final _reasonController = TextEditingController();

  // Tên app là tên thương hiệu — không dịch.
  final _availableApps = const [
    'TikTok',
    'Instagram',
    'YouTube Shorts',
    'Facebook',
    'Twitter/X',
    'Threads',
  ];
  final Set<String> _blocked = {
    'TikTok',
    'Instagram',
    'YouTube Shorts',
    'Facebook',
  };

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    final l10n = AppLocalizations.of(context);
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      showSnackBar(context, l10n.detoxSetupReasonRequiredSnackbar);
      return;
    }
    context.read<DetoxBloc>().add(
          DetoxStartRequested(
            durationDays: _duration,
            strictness: _strictness.round(),
            reason: reason,
            blockedApps: _blocked.toList(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.x, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.detoxSetupTitle),
      ),
      body: BlocListener<DetoxBloc, DetoxState>(
        listener: (context, state) {
          if (state is DetoxRunning) {
            Navigator.pop(context);
            showSnackBar(context, l10n.detoxSetupStartedSnackbar);
          } else if (state is DetoxFailure) {
            showSnackBar(context, state.message);
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.space5),
                  children: [
                    _SectionTitle(title: l10n.detoxSetupStep1),
                    const SizedBox(height: AppSpacing.space3),
                    _DurationPicker(
                      selected: _duration,
                      onChanged: (v) => setState(() => _duration = v),
                    ),
                    const SizedBox(height: AppSpacing.space6),

                    _SectionTitle(title: l10n.detoxSetupStep2),
                    const SizedBox(height: AppSpacing.space3),
                    _StrictnessSlider(
                      value: _strictness,
                      onChanged: (v) => setState(() => _strictness = v),
                    ),
                    const SizedBox(height: AppSpacing.space6),

                    _SectionTitle(title: l10n.detoxSetupStep3),
                    const SizedBox(height: AppSpacing.space3),
                    Wrap(
                      spacing: AppSpacing.space2,
                      runSpacing: AppSpacing.space2,
                      children: _availableApps
                          .map((app) => _AppChip(
                                label: app,
                                selected: _blocked.contains(app),
                                onTap: () => setState(() {
                                  if (_blocked.contains(app)) {
                                    _blocked.remove(app);
                                  } else {
                                    _blocked.add(app);
                                  }
                                }),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: AppSpacing.space6),

                    _SectionTitle(title: l10n.detoxSetupStep4),
                    const SizedBox(height: AppSpacing.space2),
                    Text(
                      l10n.detoxSetupReasonSubtitle,
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: AppSpacing.space3),
                    TextField(
                      controller: _reasonController,
                      maxLines: 4,
                      maxLength: 240,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: l10n.detoxSetupReasonHint,
                        filled: true,
                        fillColor: AppColors.surface1,
                        contentPadding:
                            const EdgeInsets.all(AppSpacing.space3),
                        border: OutlineInputBorder(
                          borderRadius: AppRadius.mdR,
                          borderSide:
                              const BorderSide(color: AppColors.borderSubtle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space5,
                  0,
                  AppSpacing.space5,
                  AppSpacing.space5,
                ),
                child: BlocBuilder<DetoxBloc, DetoxState>(
                  builder: (context, state) {
                    return AppButton(
                      label: l10n.detoxSetupStartCta(_duration),
                      icon: LucideIcons.play,
                      isLoading: state is DetoxLoading,
                      onPressed: _submit,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================ Subcomponents ============================

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.heading2);
  }
}

class _DurationPicker extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const _DurationPicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = <_DurationOption>[
      _DurationOption(
        days: 1,
        label: l10n.detoxDuration24hLabel,
        sub: l10n.detoxDuration24hSub,
      ),
      _DurationOption(
        days: 7,
        label: l10n.detoxDuration7dLabel,
        sub: l10n.detoxDuration7dSub,
      ),
      _DurationOption(
        days: 30,
        label: l10n.detoxDuration30dLabel,
        sub: l10n.detoxDuration30dSub,
      ),
    ];
    return Row(
      children: options.map((opt) {
        final active = opt.days == selected;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: AppSpacing.space2),
            child: Material(
              color: active ? AppColors.brandPrimary : AppColors.surface1,
              borderRadius: AppRadius.mdR,
              child: InkWell(
                borderRadius: AppRadius.mdR,
                onTap: () => onChanged(opt.days),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.space3),
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.mdR,
                    border: Border.all(
                      color: active
                          ? AppColors.brandPrimary
                          : AppColors.borderSubtle,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        opt.label,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: active
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        opt.sub,
                        style: AppTextStyles.caption.copyWith(
                          color: active
                              ? Colors.white.withValues(alpha: 0.8)
                              : AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _DurationOption {
  final int days;
  final String label;
  final String sub;

  const _DurationOption({
    required this.days,
    required this.label,
    required this.sub,
  });
}

class _StrictnessSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _StrictnessSlider({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = [
      l10n.detoxStrictnessLight,
      l10n.detoxStrictnessMedium,
      l10n.detoxStrictnessHard,
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.lgR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Slider(
            value: value,
            min: 1,
            max: 3,
            divisions: 2,
            label: labels[(value.round() - 1).clamp(0, 2)],
            onChanged: onChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: labels
                  .map((l) => Text(l, style: AppTextStyles.caption))
                  .toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.space3),
          Text(
            _descriptionFor(l10n, value.round()),
            style: AppTextStyles.body
                .copyWith(color: AppColors.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }

  String _descriptionFor(AppLocalizations l10n, int v) => switch (v) {
        1 => l10n.detoxStrictnessLightDesc,
        3 => l10n.detoxStrictnessHardDesc,
        _ => l10n.detoxStrictnessMediumDesc,
      };
}

class _AppChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _AppChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.cheapBg : AppColors.surface1,
      borderRadius: AppRadius.mdR,
      child: InkWell(
        borderRadius: AppRadius.mdR,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space3,
            vertical: AppSpacing.space2,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.mdR,
            border: Border.all(
              color: selected ? AppColors.cheapMain : AppColors.borderSubtle,
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? LucideIcons.ban : LucideIcons.circle,
                size: 14,
                color: selected ? AppColors.cheapFg : AppColors.textTertiary,
              ),
              const SizedBox(width: AppSpacing.space2),
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: selected ? AppColors.cheapFg : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
