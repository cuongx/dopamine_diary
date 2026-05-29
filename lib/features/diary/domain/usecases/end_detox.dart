import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

class EndDetox implements UseCase<DetoxSession, EndDetoxParams> {
  final DopamineRepository repository;
  EndDetox(this.repository);

  @override
  Future<Either<Failure, DetoxSession>> call(EndDetoxParams params) {
    return repository.endDetox(id: params.id);
  }
}

class EndDetoxParams {
  final String id;
  EndDetoxParams({required this.id});
}
