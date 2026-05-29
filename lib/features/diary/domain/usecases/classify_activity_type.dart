import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

/// User reclassify một activity type sang tier khác.
/// Dùng cho Onboarding tier setup + Settings.
class ClassifyActivityType
    implements UseCase<ActivityType, ClassifyActivityTypeParams> {
  final DopamineRepository repository;
  ClassifyActivityType(this.repository);

  @override
  Future<Either<Failure, ActivityType>> call(
    ClassifyActivityTypeParams params,
  ) {
    return repository.classifyActivityType(
      typeId: params.typeId,
      newTier: params.newTier,
    );
  }
}

class ClassifyActivityTypeParams {
  final String typeId;
  final DopamineTier newTier;

  ClassifyActivityTypeParams({
    required this.typeId,
    required this.newTier,
  });
}
