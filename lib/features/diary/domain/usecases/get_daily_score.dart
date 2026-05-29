import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetDailyScore implements UseCase<DailyScore, GetDailyScoreParams> {
  final DopamineRepository repository;
  GetDailyScore(this.repository);

  @override
  Future<Either<Failure, DailyScore>> call(GetDailyScoreParams params) {
    return repository.getDailyScore(params.date);
  }
}

class GetDailyScoreParams {
  final DateTime date;
  GetDailyScoreParams({required this.date});

  /// Helper cho ngày hôm nay (00:00 hôm nay).
  factory GetDailyScoreParams.today() {
    final now = DateTime.now();
    return GetDailyScoreParams(
      date: DateTime(now.year, now.month, now.day),
    );
  }
}
