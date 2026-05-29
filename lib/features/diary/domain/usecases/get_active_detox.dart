import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Phiên detox đang chạy. Trả `Option<None>` nếu user không detox.
class GetActiveDetox implements UseCase<Option<DetoxSession>, NoParams> {
  final DopamineRepository repository;
  GetActiveDetox(this.repository);

  @override
  Future<Either<Failure, Option<DetoxSession>>> call(NoParams params) {
    return repository.getActiveDetox();
  }
}
