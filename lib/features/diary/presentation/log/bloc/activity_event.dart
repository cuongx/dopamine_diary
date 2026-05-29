part of 'activity_bloc.dart';

@immutable
sealed class ActivityEvent {}

final class ActivityLogRequested extends ActivityEvent {
  final String name;
  final DopamineTier tier;
  final int durationMinutes;
  final String? mood;

  ActivityLogRequested({
    required this.name,
    required this.tier,
    required this.durationMinutes,
    this.mood,
  });
}

final class ActivityRecentLoadRequested extends ActivityEvent {
  final int limit;
  ActivityRecentLoadRequested({this.limit = 10});
}
