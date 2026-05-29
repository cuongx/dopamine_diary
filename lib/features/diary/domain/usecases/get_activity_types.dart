import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Lấy toàn bộ activity types (built-in seed + custom user thêm).
class GetActivityTypes implements UseCase<List<ActivityType>, NoParams> {
  final DopamineRepository repository;
  GetActivityTypes(this.repository);

  @override
  Future<Either<Failure, List<ActivityType>>> call(NoParams params) {
    return repository.getActivityTypes();
  }
}
