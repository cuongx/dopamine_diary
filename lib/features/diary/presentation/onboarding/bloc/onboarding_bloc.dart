import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/classify_activity_type.dart';
import 'package:dopamine_diary/features/diary/domain/usecases/get_activity_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

/// Bloc cho Onboarding tier setup — user kéo-thả activity types vào tier zones.
///
/// Cũng được Settings tái dùng để chỉnh tier sau onboarding.
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetActivityTypes _getActivityTypes;
  final ClassifyActivityType _classifyActivityType;

  OnboardingBloc({
    required GetActivityTypes getActivityTypes,
    required ClassifyActivityType classifyActivityType,
  })  : _getActivityTypes = getActivityTypes,
        _classifyActivityType = classifyActivityType,
        super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) => emit(OnboardingLoading()));
    on<OnboardingTypesLoadRequested>(_onLoadTypes);
    on<OnboardingTierAssigned>(_onAssignTier);
  }

  Future<void> _onLoadTypes(
    OnboardingTypesLoadRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    final res = await _getActivityTypes(NoParams());
    res.fold(
      (l) => emit(OnboardingFailure(l.message)),
      (types) => emit(OnboardingLoaded(types: types)),
    );
  }

  Future<void> _onAssignTier(
    OnboardingTierAssigned event,
    Emitter<OnboardingState> emit,
  ) async {
    final res = await _classifyActivityType(ClassifyActivityTypeParams(
      typeId: event.typeId,
      newTier: event.newTier,
    ));
    // Sau khi save, reload list để UI có data mới nhất.
    res.fold(
      (l) => emit(OnboardingFailure(l.message)),
      (_) async {
        final reload = await _getActivityTypes(NoParams());
        reload.fold(
          (l) => emit(OnboardingFailure(l.message)),
          (types) => emit(OnboardingLoaded(types: types)),
        );
      },
    );
  }
}
