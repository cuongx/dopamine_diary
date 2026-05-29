import 'package:dopamine_diary/core/common/cubits/locale/locale_cubit.dart';
import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/l10n/duration_format.dart';
import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/presentation/analytics/bloc/analytics_bloc.dart';
import 'package:dopamine_diary/features/diary/presentation/analytics/weekly_review_page.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_button.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/empty_state.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/insight_card.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/metric_card.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AnalyticsBloc>().add(AnalyticsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.analyticsTitle)),
      body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {
          if (state is AnalyticsInitial || state is AnalyticsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AnalyticsFailure) {
            return EmptyState(
              icon: LucideIcons.alertTriangle,
              title: l10n.analyticsErrorTitle,
              description: state.message,
            );
          }
          if (state is AnalyticsLoaded) {
            return _buildLoaded(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, AnalyticsLoaded state) {
    final l10n = AppLocalizations.of(context);
    final cheapMins = _totalMinutesFor(state.weeklyScores, DopamineTier.cheap);
    final deepMins = _totalMinutesFor(state.weeklyScores, DopamineTier.deep);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space5,
        AppSpacing.space4,
        AppSpacing.space5,
        AppSpacing.space10,
      ),
      children: [
        _ChartCard(scores: state.weeklyScores),
        const SizedBox(height: AppSpacing.space4),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                label: l10n.analyticsMetricCheap,
                value: formatMinutes(context, cheapMins),
                icon: LucideIcons.trendingDown,
              ),
            ),
            const SizedBox(width: AppSpacing.space3),
            Expanded(
              child: MetricCard(
                label: l10n.analyticsMetricDeep,
                value: formatMinutes(context, deepMins),
                icon: LucideIcons.trendingUp,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.space4),
        InsightCard(
          variant: InsightVariant.ai,
          title: l10n.analyticsInsightWeekendTitle,
          description: l10n.analyticsInsightWeekendDesc,
        ),
        const SizedBox(height: AppSpacing.space3),
        InsightCard(
          variant: InsightVariant.pattern,
          title: l10n.analyticsInsightExerciseTitle,
          description: l10n.analyticsInsightExerciseDesc,
        ),
        const SizedBox(height: AppSpacing.space5),
        AppButton(
          label: l10n.analyticsWeeklyReviewCta,
          icon: LucideIcons.calendar,
          variant: AppButtonVariant.tertiary,
          onPressed: () =>
              Navigator.push(context, WeeklyReviewPage.route()),
        ),
      ],
    );
  }

  int _totalMinutesFor(List<DailyScore> scores, DopamineTier tier) {
    return scores.fold(
      0,
      (sum, day) => sum + (day.minutesByTier[tier] ?? 0),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final List<DailyScore> scores;
  const _ChartCard({required this.scores});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Locale string cho DateFormat — fallback 'vi' nếu user theo system mà
    // không phải tiếng Anh, dùng intl symbol có sẵn.
    final localeCode = context.watch<LocaleCubit>().state?.languageCode ??
        Localizations.localeOf(context).languageCode;
    final dfLocale = localeCode == 'en' ? 'en' : 'vi';
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
          Text(
            l10n.analyticsScore7Days,
            style: AppTextStyles.label.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (_) => const FlLine(
                    color: AppColors.borderSubtle,
                    strokeWidth: 0.5,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 50,
                      getTitlesWidget: (value, _) => Text(
                        value.toInt().toString(),
                        style: AppTextStyles.caption,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      getTitlesWidget: (value, _) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= scores.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            DateFormat('E', dfLocale)
                                .format(scores[idx].date),
                            style: AppTextStyles.caption,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(scores.length, (i) {
                  final s = scores[i].score;
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: s.toDouble(),
                        color: _colorForScore(s),
                        width: 16,
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorForScore(int score) {
    if (score >= 70) return AppColors.deepMain;
    if (score >= 50) return AppColors.healthyMain;
    if (score >= 30) return AppColors.mediumMain;
    return AppColors.cheapMain;
  }
}
