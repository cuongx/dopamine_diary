part of 'detox_bloc.dart';

@immutable
sealed class DetoxState {}

final class DetoxInitial extends DetoxState {}

final class DetoxLoading extends DetoxState {}

final class DetoxFailure extends DetoxState {
  final String message;
  DetoxFailure(this.message);
}

/// Không có phiên detox đang chạy — show setup CTA.
final class DetoxIdle extends DetoxState {}

/// Đang trong phiên detox — show timer + lý do + blocked apps.
final class DetoxRunning extends DetoxState {
  final DetoxSession session;
  DetoxRunning(this.session);
}
