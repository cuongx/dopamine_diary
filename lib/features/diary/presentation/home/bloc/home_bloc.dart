import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_active_detox.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_current_streak.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_daily_score.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_recent_activities.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_weekly_scores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Bloc quản lý Home Dashboard — gom score hôm nay, delta so với hôm qua,
/// streak, recent activities, và phiên detox đang chạy (nếu có).
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDailyScore _getDailyScore;
  final GetWeeklyScores _getWeeklyScores;
  final GetCurrentStreak _getCurrentStreak;
  final GetRecentActivities _getRecentActivities;
  final GetActiveDetox _getActiveDetox;

  HomeBloc({
    required GetDailyScore getDailyScore,
    required GetWeeklyScores getWeeklyScores,
    required GetCurrentStreak getCurrentStreak,
    required GetRecentActivities getRecentActivities,
    required GetActiveDetox getActiveDetox,
  })  : _getDailyScore = getDailyScore,
        _getWeeklyScores = getWeeklyScores,
        _getCurrentStreak = getCurrentStreak,
        _getRecentActivities = getRecentActivities,
        _getActiveDetox = getActiveDetox,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeLoading()));
    on<HomeLoadRequested>(_onLoad);
    on<HomeRefreshRequested>(_onLoad);
  }

  Future<void> _onLoad(HomeEvent event, Emitter<HomeState> emit) async {
    final scoreRes = await _getDailyScore(GetDailyScoreParams.today());
    final weeklyRes = await _getWeeklyScores(NoParams());
    final streakRes = await _getCurrentStreak(NoParams());
    final recentRes =
        await _getRecentActivities(GetRecentActivitiesParams(limit: 8));
    final detoxRes = await _getActiveDetox(NoParams());

    // Short-circuit ở failure đầu tiên — UI chỉ cần 1 message.
    final firstFail = scoreRes.fold<String?>((l) => l.message, (_) => null) ??
        weeklyRes.fold<String?>((l) => l.message, (_) => null) ??
        streakRes.fold<String?>((l) => l.message, (_) => null) ??
        recentRes.fold<String?>((l) => l.message, (_) => null) ??
        detoxRes.fold<String?>((l) => l.message, (_) => null);
    if (firstFail != null) {
      emit(HomeFailure(firstFail));
      return;
    }

    final score = scoreRes.getRight().toNullable()!;
    final weekly = weeklyRes.getRight().toNullable()!;
    final streak = streakRes.getRight().toNullable()!;
    final recent = recentRes.getRight().toNullable()!;
    final detox = detoxRes.getRight().toNullable()!;

    // weekly[6] = today, weekly[5] = yesterday.
    final yesterday = weekly.length >= 2 ? weekly[weekly.length - 2] : null;

    emit(HomeLoaded(
      todayScore: score,
      deltaFromYesterday: score.deltaFrom(yesterday),
      streak: streak,
      recentActivities: recent,
      activeDetox: detox,
    ));
  }
}
