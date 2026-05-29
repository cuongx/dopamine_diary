import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_recent_activities.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/log_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_event.dart';
part 'activity_state.dart';

/// Bloc xử lý log + lấy recent activities (cho Quick Log + Voice Log).
class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final LogActivity _logActivity;
  final GetRecentActivities _getRecentActivities;

  ActivityBloc({
    required LogActivity logActivity,
    required GetRecentActivities getRecentActivities,
  })  : _logActivity = logActivity,
        _getRecentActivities = getRecentActivities,
        super(ActivityInitial()) {
    on<ActivityEvent>((event, emit) => emit(ActivityLoading()));
    on<ActivityLogRequested>(_onLog);
    on<ActivityRecentLoadRequested>(_onLoadRecent);
  }

  Future<void> _onLog(
    ActivityLogRequested event,
    Emitter<ActivityState> emit,
  ) async {
    final res = await _logActivity(LogActivityParams(
      name: event.name,
      tier: event.tier,
      durationMinutes: event.durationMinutes,
      mood: event.mood,
    ));
    res.fold(
      (l) => emit(ActivityFailure(l.message)),
      (r) => emit(ActivityLogSuccess(r)),
    );
  }

  Future<void> _onLoadRecent(
    ActivityRecentLoadRequested event,
    Emitter<ActivityState> emit,
  ) async {
    final res =
        await _getRecentActivities(GetRecentActivitiesParams(limit: event.limit));
    res.fold(
      (l) => emit(ActivityFailure(l.message)),
      (r) => emit(ActivityRecentLoaded(r)),
    );
  }
}
