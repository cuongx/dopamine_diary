part of 'detox_bloc.dart';

@immutable
sealed class DetoxEvent {}

/// Mở Detox tab — load phiên active hoặc Idle.
final class DetoxLoadActiveRequested extends DetoxEvent {}

final class DetoxStartRequested extends DetoxEvent {
  final int durationDays;
  final int strictness;
  final String reason;
  final List<String> blockedApps;

  DetoxStartRequested({
    required this.durationDays,
    required this.strictness,
    required this.reason,
    required this.blockedApps,
  });
}

final class DetoxEndRequested extends DetoxEvent {
  final String id;
  DetoxEndRequested({required this.id});
}
