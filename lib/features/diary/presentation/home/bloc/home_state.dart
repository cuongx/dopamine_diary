part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
}

final class HomeLoaded extends HomeState {
  final DailyScore todayScore;
  final int deltaFromYesterday;
  final int streak;
  final List<Activity> recentActivities;

  /// Phiên detox đang chạy — `None` nếu không có.
  final Option<DetoxSession> activeDetox;

  HomeLoaded({
    required this.todayScore,
    required this.deltaFromYesterday,
    required this.streak,
    required this.recentActivities,
    required this.activeDetox,
  });
}
