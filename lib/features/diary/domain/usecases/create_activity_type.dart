import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateActivityType
    implements UseCase<ActivityType, CreateActivityTypeParams> {
  final DopamineRepository repository;
  CreateActivityType(this.repository);

  @override
  Future<Either<Failure, ActivityType>> call(
    CreateActivityTypeParams params,
  ) {
    return repository.createActivityType(
      name: params.name,
      tier: params.tier,
      iconName: params.iconName,
    );
  }
}

class CreateActivityTypeParams {
  final String name;
  final DopamineTier tier;
  final String iconName;

  CreateActivityTypeParams({
    required this.name,
    required this.tier,
    required this.iconName,
  });
}
