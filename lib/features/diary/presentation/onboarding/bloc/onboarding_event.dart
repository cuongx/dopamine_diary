part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

final class OnboardingTypesLoadRequested extends OnboardingEvent {}

/// User kéo-thả 1 activity type sang tier khác.
final class OnboardingTierAssigned extends OnboardingEvent {
  final String typeId;
  final DopamineTier newTier;

  OnboardingTierAssigned({required this.typeId, required this.newTier});
}
