import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/l10n/duration_format.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:dopamine_diary/core/utils/show_snackbar.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/presentation/analytics/bloc/analytics_bloc.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Weekly Review — màn duy nhất dùng gradient tím, chữ trắng.
/// Tổng kết tuần (số giờ reclaim, highlights, pattern, goal).
class WeeklyReviewPage extends StatefulWidget {
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => const WeeklyReviewPage(),
        fullscreenDialog: true,
      );

  const WeeklyReviewPage({super.key});

  @override
  State<WeeklyReviewPage> createState() => _WeeklyReviewPageState();
}

class _WeeklyReviewPageState extends State<WeeklyReviewPage> {
  @override
  void initState() {
    super.initState();
    context.read<AnalyticsBloc>().add(AnalyticsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF26215C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(LucideIcons.x, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF26215C), Color(0xFF534AB7)],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
            builder: (context, state) {
              if (state is AnalyticsLoaded) {
                return _ReviewContent(scores: state.weeklyScores);
              }
              if (state is AnalyticsFailure) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.space5),
                    child: Text(
                      state.message,
                      style:
                          AppTextStyles.body.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ReviewContent extends StatelessWidget {
  final List<DailyScore> scores;
  const _ReviewContent({required this.scores});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reclaimMinutes = _reclaimedFromCheap(scores);
    final avgScore = _avgScore(scores);
    final bestDay = _bestDayLabel(context, scores);
    final week = _currentIsoWeek();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space5,
        AppSpacing.space5,
        AppSpacing.space5,
        AppSpacing.space6,
      ),
      children: [
        Text(
          l10n.weeklyReviewWeekLabel(week, DateTime.now().year),
          style: AppTextStyles.label.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.space2),
        Text(
          l10n.weeklyReviewTitle,
          style: AppTextStyles.display
              .copyWith(color: Colors.white, fontSize: 32),
        ),
        const SizedBox(height: AppSpacing.space6),

        // Big stat
        Text(
          l10n.weeklyReviewReclaimedLabel,
          style: AppTextStyles.body
              .copyWith(color: Colors.white.withValues(alpha: 0.85)),
        ),
        const SizedBox(height: AppSpacing.space2),
        Text(
          formatMinutes(context, reclaimMinutes),
          style: GoogleFonts.inter(
            fontSize: 56,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 1,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.space1),
        Text(
          l10n.weeklyReviewReclaimedFrom,
          style: AppTextStyles.body
              .copyWith(color: Colors.white.withValues(alpha: 0.75)),
        ),

        const SizedBox(height: AppSpacing.space6),
        _GlassCard(
          label: l10n.weeklyReviewHighlightsLabel,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HighlightRow(
                emoji: '🏃',
                text: l10n.weeklyReviewHighlightExercise(
                  _exerciseDays(scores),
                  scores.length,
                ),
              ),
              _HighlightRow(
                emoji: '📚',
                text: l10n.weeklyReviewHighlightDeep(
                  formatMinutes(context, _deepMinutes(scores)),
                ),
              ),
              _HighlightRow(
                emoji: '🌙',
                text: l10n.weeklyReviewHighlightScore(avgScore),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space4),
        _GlassCard(
          label: l10n.weeklyReviewPatternLabel,
          child: Text(
            l10n.weeklyReviewPatternDesc,
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space4),
        _GlassCard(
          label: l10n.weeklyReviewGoalsLabel,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GoalRow(text: l10n.weeklyReviewGoal1),
              _GoalRow(text: l10n.weeklyReviewGoal2(bestDay)),
              _GoalRow(text: l10n.weeklyReviewGoal3),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.space6),
        ElevatedButton.icon(
          onPressed: () => showSnackBar(
            context,
            l10n.weeklyReviewShareUnavailable,
          ),
          icon: const Icon(LucideIcons.share2, size: 18),
          label: Text(l10n.weeklyReviewShareCta),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF26215C),
            minimumSize: const Size(double.infinity, 48),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.mdR),
            textStyle: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }

  int _reclaimedFromCheap(List<DailyScore> scores) {
    final cheapTotal = scores
        .map((s) => s.minutesByTier[DopamineTier.cheap] ?? 0)
        .fold<int>(0, (a, b) => a + b);
    // Giả định baseline 3h/ngày short video (theo nghiên cứu trung bình).
    const baselineWeeklyCheap = 7 * 180;
    final reclaimed = (baselineWeeklyCheap - cheapTotal).clamp(0, 9999);
    return reclaimed;
  }

  int _avgScore(List<DailyScore> scores) {
    if (scores.isEmpty) return 0;
    final sum = scores.fold<int>(0, (a, s) => a + s.score);
    return (sum / scores.length).round();
  }

  String _bestDayLabel(BuildContext context, List<DailyScore> scores) {
    if (scores.isEmpty) return '—';
    final l10n = AppLocalizations.of(context);
    final best = scores.reduce((a, b) => a.score >= b.score ? a : b);
    final names = [
      l10n.weekdayMon,
      l10n.weekdayTue,
      l10n.weekdayWed,
      l10n.weekdayThu,
      l10n.weekdayFri,
      l10n.weekdaySat,
      l10n.weekdaySun,
    ];
    return names[best.date.weekday - 1];
  }

  int _exerciseDays(List<DailyScore> scores) {
    return scores
        .where((s) => (s.minutesByTier[DopamineTier.healthy] ?? 0) > 0)
        .length;
  }

  int _deepMinutes(List<DailyScore> scores) {
    return scores
        .map((s) => s.minutesByTier[DopamineTier.deep] ?? 0)
        .fold<int>(0, (a, b) => a + b);
  }

  int _currentIsoWeek() {
    // ISO 8601: tuần chứa thứ 5 đầu tiên của năm là tuần 1.
    final now = DateTime.now();
    final thursday = now.add(Duration(days: 4 - (now.weekday)));
    final firstThursday = DateTime(thursday.year, 1, 4);
    final daysToFirstThursday =
        thursday.difference(firstThursday).inDays;
    return 1 + (daysToFirstThursday / 7).floor();
  }
}

// ============================ Cards & rows ============================

class _GlassCard extends StatelessWidget {
  final String label;
  final Widget child;
  const _GlassCard({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: AppRadius.lgR,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.label.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),
          child,
        ],
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  final String emoji;
  final String text;
  const _HighlightRow({required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: AppSpacing.space3),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalRow extends StatelessWidget {
  final String text;
  const _GoalRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LucideIcons.target,
              size: 16, color: Colors.white),
          const SizedBox(width: AppSpacing.space2),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(
                color: Colors.white.withValues(alpha: 0.92),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
