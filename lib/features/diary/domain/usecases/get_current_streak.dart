import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Số ngày liên tiếp gần nhất đạt ngưỡng "cân bằng".
class GetCurrentStreak implements UseCase<int, NoParams> {
  final DopamineRepository repository;
  GetCurrentStreak(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) {
    return repository.getCurrentStreak();
  }
}
