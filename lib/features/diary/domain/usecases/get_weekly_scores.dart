import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

/// 7 ngày gần nhất theo thứ tự thời gian (cũ → mới).
/// Dùng cho Home delta hôm-qua + Analytics bar chart.
class GetWeeklyScores implements UseCase<List<DailyScore>, NoParams> {
  final DopamineRepository repository;
  GetWeeklyScores(this.repository);

  @override
  Future<Either<Failure, List<DailyScore>>> call(NoParams params) {
    return repository.getWeeklyScores();
  }
}
