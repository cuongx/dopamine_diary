import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogActivity implements UseCase<Activity, LogActivityParams> {
  final DopamineRepository repository;
  LogActivity(this.repository);

  @override
  Future<Either<Failure, Activity>> call(LogActivityParams params) async {
    return repository.logActivity(
      name: params.name,
      tier: params.tier,
      durationMinutes: params.durationMinutes,
      mood: params.mood,
    );
  }
}

class LogActivityParams {
  final String name;
  final DopamineTier tier;
  final int durationMinutes;
  final String? mood;

  LogActivityParams({
    required this.name,
    required this.tier,
    required this.durationMinutes,
    this.mood,
  });
}
