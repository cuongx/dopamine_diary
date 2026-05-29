part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingFailure extends OnboardingState {
  final String message;
  OnboardingFailure(this.message);
}

final class OnboardingLoaded extends OnboardingState {
  final List<ActivityType> types;
  OnboardingLoaded({required this.types});

  /// Helper UI dùng để group theo tier.
  Map<DopamineTier, List<ActivityType>> get typesByTier {
    final map = <DopamineTier, List<ActivityType>>{
      for (final tier in DopamineTier.values) tier: [],
    };
    for (final type in types) {
      map[type.tier]!.add(type);
    }
    return map;
  }
}
