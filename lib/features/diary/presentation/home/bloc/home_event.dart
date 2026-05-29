part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

/// Lần đầu vào Home — load toàn bộ dashboard.
final class HomeLoadRequested extends HomeEvent {}

/// Pull-to-refresh hoặc trigger lại sau khi có activity mới được log.
final class HomeRefreshRequested extends HomeEvent {}
