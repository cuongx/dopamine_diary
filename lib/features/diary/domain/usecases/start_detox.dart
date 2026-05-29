import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

class StartDetox implements UseCase<DetoxSession, StartDetoxParams> {
  final DopamineRepository repository;
  StartDetox(this.repository);

  @override
  Future<Either<Failure, DetoxSession>> call(StartDetoxParams params) {
    return repository.startDetox(
      durationDays: params.durationDays,
      strictness: params.strictness,
      reason: params.reason,
      blockedApps: params.blockedApps,
    );
  }
}

class StartDetoxParams {
  final int durationDays;
  final int strictness;
  final String reason;
  final List<String> blockedApps;

  StartDetoxParams({
    required this.durationDays,
    required this.strictness,
    required this.reason,
    required this.blockedApps,
  });
}
