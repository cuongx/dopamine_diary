part of 'analytics_bloc.dart';

@immutable
sealed class AnalyticsState {}

final class AnalyticsInitial extends AnalyticsState {}

final class AnalyticsLoading extends AnalyticsState {}

final class AnalyticsFailure extends AnalyticsState {
  final String message;
  AnalyticsFailure(this.message);
}

final class AnalyticsLoaded extends AnalyticsState {
  /// 7 entries cũ→mới (today ở index cuối).
  final List<DailyScore> weeklyScores;

  AnalyticsLoaded({required this.weeklyScores});
}
