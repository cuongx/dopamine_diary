import 'package:dopamine_diary/core/l10n/duration_format.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:dopamine_diary/features/diary/presentation/home/bloc/home_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/log/quick_log_page.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/activity_row.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/empty_state.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/score_ring.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/tier_bar.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_greetingForHour(context, DateTime.now().hour)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCw, size: 20),
            onPressed: () =>
                context.read<HomeBloc>().add(HomeRefreshRequested()),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeFailure) {
            return EmptyState(
              icon: LucideIcons.alertTriangle,
              title: l10n.homeErrorTitle,
              description: state.message,
              ctaLabel: l10n.commonRetry,
              onCtaPressed: () =>
                  context.read<HomeBloc>().add(HomeRefreshRequested()),
            );
          }
          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeRefreshRequested());
              },
              child: _buildLoaded(context, state),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, HomeLoaded s) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space5,
        AppSpacing.space4,
        AppSpacing.space5,
        AppSpacing.space10,
      ),
      children: [
        _ScoreCard(score: s.todayScore, delta: s.deltaFromYesterday),
        const SizedBox(height: AppSpacing.space5),
        _TierBarCard(score: s.todayScore),
        const SizedBox(height: AppSpacing.space5),
        AppButton(
          label: l10n.homeQuickLogCta,
          icon: LucideIcons.plus,
          onPressed: () async {
            await Navigator.push(context, QuickLogPage.route());
            if (!context.mounted) return;
            context.read<HomeBloc>().add(HomeRefreshRequested());
          },
        ),
        if (s.streak > 0) ...[
          const SizedBox(height: AppSpacing.space4),
          _StreakCard(streak: s.streak),
        ],
        s.activeDetox.fold(
          () => const SizedBox.shrink(),
          (session) => Padding(
            padding: const EdgeInsets.only(top: AppSpacing.space4),
            child: _DetoxBanner(session: session),
          ),
        ),
        const SizedBox(height: AppSpacing.space6),
        _SectionTitle(l10n.homeRecentSection),
        const SizedBox(height: AppSpacing.space3),
        if (s.recentActivities.isEmpty)
          const _RecentEmpty()
        else
          ...s.recentActivities.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.space2),
                child: ActivityRow(activity: a),
              )),
      ],
    );
  }

  String _greetingForHour(BuildContext context, int hour) {
    final l10n = AppLocalizations.of(context);
    if (hour < 12) return l10n.homeGreetingMorning;
    if (hour < 18) return l10n.homeGreetingAfternoon;
    return l10n.homeGreetingEvening;
  }
}

// ============================ Subcomponents ============================

class _ScoreCard extends StatelessWidget {
  final DailyScore score;
  final int delta;

  const _ScoreCard({required this.score, required this.delta});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space5),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.lgR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        children: [
          ScoreRing(score: score.score, size: 160),
          const SizedBox(height: AppSpacing.space4),
          Text(_labelFor(context, score.score), style: AppTextStyles.heading2),
          const SizedBox(height: AppSpacing.space1),
          _DeltaRow(delta: delta),
        ],
      ),
    );
  }

  static String _labelFor(BuildContext context, int score) {
    final l10n = AppLocalizations.of(context);
    if (score >= 80) return l10n.homeScoreExcellent;
    if (score >= 70) return l10n.homeScoreBalanced;
    if (score >= 60) return l10n.homeScoreOk;
    if (score >= 50) return l10n.homeScoreAdjust;
    return l10n.homeScoreAttention;
  }
}

class _DeltaRow extends StatelessWidget {
  final int delta;
  const _DeltaRow({required this.delta});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (delta == 0) {
      return Text(
        l10n.homeDeltaSame,
        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
      );
    }
    final positive = delta > 0;
    final color = positive ? AppColors.healthyFg : AppColors.cheapFg;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          positive ? LucideIcons.trendingUp : LucideIcons.trendingDown,
          size: 14,
          color: color,
        ),
        const SizedBox(width: AppSpacing.space1),
        Text(
          l10n.homeDeltaCompare(positive ? '+' : '', delta),
          style: AppTextStyles.caption.copyWith(color: color),
        ),
      ],
    );
  }
}

class _TierBarCard extends StatelessWidget {
  final DailyScore score;
  const _TierBarCard({required this.score});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percentByTier = {
      for (final t in score.minutesByTier.keys) t: score.percentOf(t),
    };
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
                l10n.homeTodayDistribution,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.textTertiary,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                l10n.homeTodayMinutes(score.totalMinutes),
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space3),
          TierBar(percentByTier: percentByTier),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final int streak;
  const _StreakCard({required this.streak});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.mediumBg,
        borderRadius: AppRadius.lgR,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.mediumMain,
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.flame,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: AppSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.homeStreakDays(streak),
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.mediumText),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.homeStreakSubtitle,
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.mediumFg),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetoxBanner extends StatelessWidget {
  final DetoxSession session;
  const _DetoxBanner({required this.session});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final remaining = session.remainingFrom(DateTime.now());
    final remainingStr = formatRemainingDays(context, remaining);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: AppColors.brandPrimaryBg,
        borderRadius: AppRadius.lgR,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.brandPrimary,
              shape: BoxShape.circle,
            ),
            child:
                const Icon(LucideIcons.zap, color: Colors.white, size: 22),
          ),
          const SizedBox(width: AppSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.homeDetoxBannerTitle,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.brandPrimaryText),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.homeDetoxBannerRemaining(
                      remainingStr, session.durationDays),
                  style: AppTextStyles.caption
                      .copyWith(color: AppColors.brandPrimary),
                ),
              ],
            ),
          ),
        ],
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

class _RecentEmpty extends StatelessWidget {
  const _RecentEmpty();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.space6,
        horizontal: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: AppRadius.lgR,
        border: Border.all(color: AppColors.borderSubtle, width: 0.5),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.surface2,
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.inbox,
                size: 22, color: AppColors.textTertiary),
          ),
          const SizedBox(height: AppSpacing.space2),
          Text(
            l10n.homeEmptyTodayTitle,
            style: AppTextStyles.body
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.space1),
          Text(
            l10n.homeEmptyTodaySubtitle,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
