part of 'activity_bloc.dart';

@immutable
sealed class ActivityState {}

final class ActivityInitial extends ActivityState {}

final class ActivityLoading extends ActivityState {}

final class ActivityFailure extends ActivityState {
  final String message;
  ActivityFailure(this.message);
}

/// Sau khi log thành công — page có thể pop hoặc show animation success.
final class ActivityLogSuccess extends ActivityState {
  final Activity activity;
  ActivityLogSuccess(this.activity);
}

/// Recent activities list cho Quick Log gợi ý.
final class ActivityRecentLoaded extends ActivityState {
  final List<Activity> activities;
  ActivityRecentLoaded(this.activities);
}
