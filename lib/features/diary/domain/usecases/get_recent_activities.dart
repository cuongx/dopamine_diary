import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/core/usecase/usecase.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetRecentActivities
    implements UseCase<List<Activity>, GetRecentActivitiesParams> {
  final DopamineRepository repository;
  GetRecentActivities(this.repository);

  @override
  Future<Either<Failure, List<Activity>>> call(
    GetRecentActivitiesParams params,
  ) {
    return repository.getRecentActivities(limit: params.limit);
  }
}

class GetRecentActivitiesParams {
  final int limit;
  GetRecentActivitiesParams({this.limit = 10});
}
