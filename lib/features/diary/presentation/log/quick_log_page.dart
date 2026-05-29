import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/l10n/duration_format.dart';
import 'package:dopamine_diary/core/l10n/tier_labels.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/core/utils/show_snackbar.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/presentation/log/bloc/activity_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/log/voice_log_page.dart';
import 'package:dopamine_diary/features/diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/activity_row.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/lucide_icon_map.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Quick Log — chọn 1 activity type, chọn thời lượng, log.
/// Có recent activities ở đầu để repeat nhanh.
class QuickLogPage extends StatefulWidget {
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => const QuickLogPage(),
        fullscreenDialog: true,
      );

  const QuickLogPage({super.key});

  @override
  State<QuickLogPage> createState() => _QuickLogPageState();
}

class _QuickLogPageState extends State<QuickLogPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(OnboardingTypesLoadRequested());
    context.read<ActivityBloc>().add(ActivityRecentLoadRequested(limit: 3));
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
        title: Text(l10n.quickLogTitle),
      ),
      body: BlocListener<ActivityBloc, ActivityState>(
        listener: (context, state) {
          if (state is ActivityLogSuccess) {
            // Đóng Quick Log, Home sẽ refresh khi quay lại.
            Navigator.pop(context);
          } else if (state is ActivityFailure) {
            showSnackBar(context, state.message);
          }
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space5,
            AppSpacing.space3,
            AppSpacing.space5,
            AppSpacing.space10,
          ),
          children: [
            Text(
              l10n.quickLogQuestion,
              style: AppTextStyles.heading1,
            ),
            const SizedBox(height: AppSpacing.space1),
            Text(
              l10n.quickLogSubtitle,
              style: AppTextStyles.body
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space5),

            // ============ Recent (lặp lại nhanh) ============
            BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
                if (state is! ActivityRecentLoaded ||
                    state.activities.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(l10n.quickLogRecentSection),
                    const SizedBox(height: AppSpacing.space3),
                    ...state.activities.map((a) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.space2),
                          child: ActivityRow(
                            activity: a,
                            onTap: () => _quickRepeat(context, a.name, a.tier,
                                a.durationMinutes),
                          ),
                        )),
                    const SizedBox(height: AppSpacing.space5),
                  ],
                );
              },
            ),

            // ============ Activity types theo tier ============
            _SectionTitle(l10n.quickLogActivitiesSection),
            const SizedBox(height: AppSpacing.space3),
            BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state is OnboardingLoaded) {
                  return Column(
                    children: DopamineTier.values.map((tier) {
                      final types = state.typesByTier[tier] ?? [];
                      if (types.isEmpty) return const SizedBox.shrink();
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppSpacing.space4),
                        child: _TierSection(tier: tier, types: types),
                      );
                    }).toList(),
                  );
                }
                if (state is OnboardingFailure) {
                  return Text(state.message,
                      style: AppTextStyles.caption.copyWith(
                          color: AppColors.cheapFg));
                }
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.space5),
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),

            const SizedBox(height: AppSpacing.space5),
            AppButton(
              label: l10n.quickLogVoiceCta,
              icon: LucideIcons.mic,
              variant: AppButtonVariant.tertiary,
              onPressed: () =>
                  Navigator.push(context, VoiceLogPage.route()),
            ),
          ],
        ),
      ),
    );
  }

  void _quickRepeat(
      BuildContext context, String name, DopamineTier tier, int minutes) {
    context.read<ActivityBloc>().add(
          ActivityLogRequested(
            name: name,
            tier: tier,
            durationMinutes: minutes,
          ),
        );
  }
}

class _TierSection extends StatelessWidget {
  final DopamineTier tier;
  final List<ActivityType> types;

  const _TierSection({required this.tier, required this.types});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration:
                  BoxDecoration(color: tier.main, shape: BoxShape.circle),
            ),
            const SizedBox(width: AppSpacing.space2),
            Text(
              tier.label(context),
              style: AppTextStyles.bodyMedium
                  .copyWith(color: tier.textColor),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.space2),
        Wrap(
          spacing: AppSpacing.space2,
          runSpacing: AppSpacing.space2,
          children: types
              .map((t) => _ActivityTypeChip(
                    type: t,
                    onTap: () => _onTap(context, t),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _onTap(BuildContext context, ActivityType type) async {
    final minutes = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: AppColors.surface1,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (_) => _DurationSheet(typeName: type.name, tier: type.tier),
    );
    if (minutes == null) return;
    if (!context.mounted) return;
    context.read<ActivityBloc>().add(
          ActivityLogRequested(
            name: type.name,
            tier: type.tier,
            durationMinutes: minutes,
          ),
        );
  }
}

class _ActivityTypeChip extends StatelessWidget {
  final ActivityType type;
  final VoidCallback onTap;

  const _ActivityTypeChip({required this.type, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: type.tier.bg,
      borderRadius: AppRadius.mdR,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdR,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space3,
            vertical: AppSpacing.space2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIconMap.of(type.iconName),
                  size: 16, color: type.tier.fg),
              const SizedBox(width: AppSpacing.space2),
              Text(
                type.name,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: type.tier.textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DurationSheet extends StatefulWidget {
  final String typeName;
  final DopamineTier tier;

  const _DurationSheet({required this.typeName, required this.tier});

  @override
  State<_DurationSheet> createState() => _DurationSheetState();
}

class _DurationSheetState extends State<_DurationSheet> {
  int _minutes = 30;
  static const _options = [5, 15, 30, 45, 60, 90, 120];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderDefault,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space4),
            Text(widget.typeName, style: AppTextStyles.heading2),
            const SizedBox(height: AppSpacing.space1),
            Text(
              l10n.durationSheetQuestion,
              style: AppTextStyles.body
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space4),
            Wrap(
              spacing: AppSpacing.space2,
              runSpacing: AppSpacing.space2,
              children: _options.map((m) {
                final selected = m == _minutes;
                return InkWell(
                  onTap: () => setState(() => _minutes = m),
                  borderRadius: AppRadius.mdR,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space4,
                      vertical: AppSpacing.space2,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? widget.tier.main
                          : AppColors.surface2,
                      borderRadius: AppRadius.mdR,
                    ),
                    child: Text(
                      formatMinutes(context, m),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color:
                            selected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.space5),
            AppButton(
              label: l10n.durationSheetSaveLabel(
                  formatMinutes(context, _minutes)),
              onPressed: () => Navigator.pop(context, _minutes),
            ),
            const SizedBox(height: AppSpacing.space2),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.label.copyWith(
        color: AppColors.textTertiary,
        letterSpacing: 1.0,
      ),
    );
  }
}
