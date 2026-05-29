import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_weekly_scores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

/// Bloc cho màn Analytics — bar chart 7 ngày + insight cards.
class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetWeeklyScores _getWeeklyScores;

  AnalyticsBloc({required GetWeeklyScores getWeeklyScores})
      : _getWeeklyScores = getWeeklyScores,
        super(AnalyticsInitial()) {
    on<AnalyticsEvent>((event, emit) => emit(AnalyticsLoading()));
    on<AnalyticsLoadRequested>(_onLoad);
  }

  Future<void> _onLoad(
    AnalyticsLoadRequested event,
    Emitter<AnalyticsState> emit,
  ) async {
    final res = await _getWeeklyScores(NoParams());
    res.fold(
      (l) => emit(AnalyticsFailure(l.message)),
      (r) => emit(AnalyticsLoaded(weeklyScores: r)),
    );
  }
}
