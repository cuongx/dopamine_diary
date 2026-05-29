import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/l10n/tier_labels.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/onboarding/widgets/tier_zone.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/lucide_icon_map.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Onboarding 5 bước (welcome → triết lý → phân loại tier → cam kết → xong).
/// Step 3 là drag-drop activity types vào tier zone; user có thể tap chip
/// để mở sheet chọn tier (fallback cho user không quen drag-drop).
class OnboardingPage extends StatefulWidget {
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => const OnboardingPage(),
        fullscreenDialog: true,
      );

  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  int _step = 0;
  static const _totalSteps = 5;

  @override
  void initState() {
    super.initState();
    // Pre-load activity types để step 3 sẵn data.
    context.read<OnboardingBloc>().add(OnboardingTypesLoadRequested());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_step >= _totalSteps - 1) {
      Navigator.pop(context);
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _goBack() {
    if (_step == 0) {
      Navigator.pop(context);
      return;
    }
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, size: 22),
          onPressed: _goBack,
        ),
        title: _ProgressBar(step: _step + 1, total: _totalSteps),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _step = i),
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _WelcomeStep(),
                  _PhilosophyStep(),
                  _TierSetupStep(),
                  _CommitmentStep(),
                  _DoneStep(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space5,
                AppSpacing.space3,
                AppSpacing.space5,
                AppSpacing.space5,
              ),
              child: AppButton(
                label: _step == _totalSteps - 1
                    ? l10n.onboardingFinishCta
                    : l10n.commonContinue,
                icon: _step == _totalSteps - 1
                    ? LucideIcons.check
                    : LucideIcons.arrowRight,
                onPressed: _goNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final int step;
  final int total;
  const _ProgressBar({required this.step, required this.total});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: step / total,
              minHeight: 4,
              backgroundColor: AppColors.surface2,
              valueColor:
                  const AlwaysStoppedAnimation(AppColors.brandPrimary),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.space3),
        Text(
          l10n.onboardingStepIndicator(step, total),
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}

// ============================ Step 1 — Welcome ============================

class _WelcomeStep extends StatelessWidget {
  const _WelcomeStep();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.space6),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.brandPrimaryBg,
              borderRadius: AppRadius.lgR,
            ),
            child: const Icon(
              LucideIcons.sparkles,
              size: 32,
              color: AppColors.brandPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.space5),
          Text(
            l10n.onboardingStep1Title,
            style: AppTextStyles.display.copyWith(fontSize: 32),
          ),
          const SizedBox(height: AppSpacing.space3),
          Text(
            l10n.onboardingStep1Desc,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          Text(
            l10n.onboardingStep1SetupTime,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}

// ============================ Step 2 — Philosophy ============================

class _PhilosophyStep extends StatelessWidget {
  const _PhilosophyStep();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space5),
      children: [
        const SizedBox(height: AppSpacing.space4),
        Text(
          l10n.onboardingStep2Title,
          style: AppTextStyles.display.copyWith(fontSize: 28),
        ),
        const SizedBox(height: AppSpacing.space3),
        Text(
          l10n.onboardingStep2Desc,
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.55,
          ),
        ),
        const SizedBox(height: AppSpacing.space6),
        ...DopamineTier.values.map(_TierIntroRow.new),
      ],
    );
  }
}

class _TierIntroRow extends StatelessWidget {
  final DopamineTier tier;
  const _TierIntroRow(this.tier);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space3),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space4),
        decoration: BoxDecoration(
          color: tier.bg,
          borderRadius: AppRadius.lgR,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: tier.main,
                borderRadius: AppRadius.smR,
              ),
              child: Icon(_iconFor(tier), size: 18, color: Colors.white),
            ),
            const SizedBox(width: AppSpacing.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tier.label(context),
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: tier.textColor),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _exampleFor(context, tier),
                    style: AppTextStyles.caption.copyWith(color: tier.fg),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(DopamineTier t) => switch (t) {
        DopamineTier.cheap => LucideIcons.video,
        DopamineTier.medium => LucideIcons.coffee,
        DopamineTier.healthy => LucideIcons.dumbbell,
        DopamineTier.deep => LucideIcons.bookOpen,
      };

  String _exampleFor(BuildContext context, DopamineTier t) {
    final l10n = AppLocalizations.of(context);
    return switch (t) {
      DopamineTier.cheap => l10n.tierExampleCheap,
      DopamineTier.medium => l10n.tierExampleMedium,
      DopamineTier.healthy => l10n.tierExampleHealthy,
      DopamineTier.deep => l10n.tierExampleDeep,
    };
  }
}

// ============================ Step 3 — Tier setup ============================

class _TierSetupStep extends StatelessWidget {
  const _TierSetupStep();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space5,
            AppSpacing.space4,
            AppSpacing.space5,
            AppSpacing.space2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.onboardingStep3Title,
                style: AppTextStyles.heading1,
              ),
              const SizedBox(height: AppSpacing.space2),
              Text(
                l10n.onboardingStep3Desc,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              if (state is OnboardingLoaded) {
                return _TierSetupBoard(state: state);
              }
              if (state is OnboardingFailure) {
                return Padding(
                  padding: const EdgeInsets.all(AppSpacing.space5),
                  child: Text(
                    state.message,
                    style: AppTextStyles.body
                        .copyWith(color: AppColors.cheapFg),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}

class _TierSetupBoard extends StatelessWidget {
  final OnboardingLoaded state;
  const _TierSetupBoard({required this.state});

  @override
  Widget build(BuildContext context) {
    final byTier = state.typesByTier;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space5,
        AppSpacing.space2,
        AppSpacing.space5,
        AppSpacing.space6,
      ),
      children: DopamineTier.values
          .map(
            (tier) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space3),
              child: TierZone(
                tier: tier,
                types: byTier[tier] ?? const [],
                onAssign: (typeId, newTier) {
                  context.read<OnboardingBloc>().add(
                        OnboardingTierAssigned(
                          typeId: typeId,
                          newTier: newTier,
                        ),
                      );
                },
                onChipTap: (type) => _openReassignSheet(context, type),
              ),
            ),
          )
          .toList(),
    );
  }

  void _openReassignSheet(BuildContext context, ActivityType type) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface1,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (_) => _ReassignSheet(type: type),
    );
  }
}

class _ReassignSheet extends StatelessWidget {
  final ActivityType type;
  const _ReassignSheet({required this.type});

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
            Row(
              children: [
                Icon(LucideIconMap.of(type.iconName),
                    size: 18, color: type.tier.fg),
                const SizedBox(width: AppSpacing.space2),
                Text(type.name, style: AppTextStyles.heading2),
              ],
            ),
            const SizedBox(height: AppSpacing.space1),
            Text(
              l10n.onboardingReassignQuestion,
              style: AppTextStyles.body
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.space4),
            ...DopamineTier.values.map(
              (tier) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.space2),
                child: InkWell(
                  borderRadius: AppRadius.mdR,
                  onTap: () {
                    context.read<OnboardingBloc>().add(
                          OnboardingTierAssigned(
                            typeId: type.id,
                            newTier: tier,
                          ),
                        );
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.space4),
                    decoration: BoxDecoration(
                      color: tier.bg,
                      borderRadius: AppRadius.mdR,
                      border: tier == type.tier
                          ? Border.all(color: tier.main, width: 1.5)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: tier.main,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space3),
                        Text(
                          tier.label(context),
                          style: AppTextStyles.bodyMedium
                              .copyWith(color: tier.textColor),
                        ),
                        const Spacer(),
                        if (tier == type.tier)
                          Icon(LucideIcons.check, size: 18, color: tier.fg),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================ Step 4 — Commitment ============================

class _CommitmentStep extends StatelessWidget {
  const _CommitmentStep();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.space4),
          Text(
            l10n.onboardingStep4Title,
            style: AppTextStyles.display.copyWith(fontSize: 28),
          ),
          const SizedBox(height: AppSpacing.space3),
          Text(
            l10n.onboardingStep4Desc,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.55,
            ),
          ),
          const SizedBox(height: AppSpacing.space6),
          _Bullet(
            icon: LucideIcons.shield,
            text: l10n.onboardingBulletPrivacy,
          ),
          _Bullet(
            icon: LucideIcons.bellOff,
            text: l10n.onboardingBulletNoNotifications,
          ),
          _Bullet(
            icon: LucideIcons.heart,
            text: l10n.onboardingBulletEmpathy,
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Bullet({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.accentCalmBg,
              borderRadius: AppRadius.smR,
            ),
            child: Icon(icon, size: 14, color: AppColors.accentCalm),
          ),
          const SizedBox(width: AppSpacing.space3),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body
                  .copyWith(color: AppColors.textPrimary, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================ Step 5 — Done ============================

class _DoneStep extends StatelessWidget {
  const _DoneStep();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              color: AppColors.healthyBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.check,
              size: 48,
              color: AppColors.healthyFg,
            ),
          ),
          const SizedBox(height: AppSpacing.space5),
          Text(
            l10n.onboardingStep5Title,
            style: AppTextStyles.display.copyWith(fontSize: 32),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.space3),
          Text(
            l10n.onboardingStep5Desc,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
