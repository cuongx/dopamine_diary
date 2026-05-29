import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Lấy activities đã log trong ngày hôm nay (từ 00:00 tới hiện tại).
class GetTodayActivities implements UseCase<List<Activity>, NoParams> {
  final DopamineRepository repository;
  GetTodayActivities(this.repository);

  @override
  Future<Either<Failure, List<Activity>>> call(NoParams params) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfTomorrow = startOfDay.add(const Duration(days: 1));
    return repository.getActivitiesBetween(
      from: startOfDay,
      to: startOfTomorrow,
    );
  }
}
