import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/features/diary/data/datasources/dopamine_local_data_source.dart';
import 'package:dopamine_diary/features/diary/data/models/activity_model.dart';
import 'package:dopamine_diary/features/diary/data/models/activity_type_model.dart';
import 'package:dopamine_diary/features/diary/data/models/detox_session_model.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:dopamine_diary/features/diary/domain/repositories/dopamine_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class DopamineRepositoryImpl implements DopamineRepository {
  final DopamineLocalDataSource localDataSource;
  final Uuid _uuid;

  /// Score 0-100, base 50. Mỗi activity cộng/trừ vào base theo `scoreImpact`.
  static const int _baseScore = 50;

  /// Ngưỡng "cân bằng" để tính streak — score >= 60 coi là ngày tốt.
  static const int _balanceScoreThreshold = 60;

  DopamineRepositoryImpl({
    required this.localDataSource,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid();

  // ============================== Activities ==============================

  @override
  Future<Either<Failure, Activity>> logActivity({
    required String name,
    required DopamineTier tier,
    required int durationMinutes,
    String? mood,
  }) async {
    try {
      final model = ActivityModel(
        id: _uuid.v4(),
        name: name,
        tier: tier,
        durationMinutes: durationMinutes,
        timestamp: DateTime.now(),
        mood: mood,
        scoreImpact: _calculateScoreImpact(tier, durationMinutes),
      );
      localDataSource.saveActivity(model);
      return right(model);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Activity>>> getActivitiesBetween({
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final all = localDataSource.getAllActivities();
      final filtered = all
          .where((a) =>
              !a.timestamp.isBefore(from) && a.timestamp.isBefore(to))
          .toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return right(filtered);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Activity>>> getRecentActivities({
    int limit = 10,
  }) async {
    try {
      final all = localDataSource.getAllActivities()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return right(all.take(limit).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // ============================ Activity types ============================

  @override
  Future<Either<Failure, List<ActivityType>>> getActivityTypes() async {
    try {
      localDataSource.seedDefaultActivityTypesIfEmpty();
      final all = localDataSource.getAllActivityTypes();
      return right(all);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActivityType>> createActivityType({
    required String name,
    required DopamineTier tier,
    required String iconName,
  }) async {
    try {
      final model = ActivityTypeModel(
        id: _uuid.v4(),
        name: name,
        tier: tier,
        iconName: iconName,
      );
      localDataSource.saveActivityType(model);
      return right(model);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActivityType>> classifyActivityType({
    required String typeId,
    required DopamineTier newTier,
  }) async {
    try {
      final all = localDataSource.getAllActivityTypes();
      final current = all.where((t) => t.id == typeId).firstOrNull;
      if (current == null) {
        return left(Failure('Không tìm thấy activity type với id $typeId'));
      }
      final updated = ActivityTypeModel(
        id: current.id,
        name: current.name,
        tier: newTier,
        iconName: current.iconName,
      );
      localDataSource.saveActivityType(updated);
      return right(updated);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // ============================ Score & analytics ============================

  @override
  Future<Either<Failure, DailyScore>> getDailyScore(DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      final dayActivities = localDataSource
          .getAllActivities()
          .where((a) =>
              !a.timestamp.isBefore(startOfDay) &&
              a.timestamp.isBefore(endOfDay))
          .toList();

      return right(_buildDailyScore(startOfDay, dayActivities));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DailyScore>>> getWeeklyScores() async {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      // Đọc một lần, group theo ngày để tránh quét list 7 lần.
      final all = localDataSource.getAllActivities();
      final byDay = <DateTime, List<ActivityModel>>{};
      for (final a in all) {
        final day =
            DateTime(a.timestamp.year, a.timestamp.month, a.timestamp.day);
        byDay.putIfAbsent(day, () => []).add(a);
      }

      // 7 ngày cũ → mới (today-6 ... today).
      final result = <DailyScore>[];
      for (int i = 6; i >= 0; i--) {
        final day = today.subtract(Duration(days: i));
        result.add(_buildDailyScore(day, byDay[day] ?? const []));
      }
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getCurrentStreak() async {
    try {
      final all = localDataSource.getAllActivities();
      if (all.isEmpty) return right(0);

      // Group theo ngày, compute score per day.
      final byDay = <DateTime, List<ActivityModel>>{};
      for (final a in all) {
        final day =
            DateTime(a.timestamp.year, a.timestamp.month, a.timestamp.day);
        byDay.putIfAbsent(day, () => []).add(a);
      }

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      int streak = 0;
      // Đi ngược từ hôm nay; streak tính cả khi today chưa có activity nhưng
      // hôm qua đạt ngưỡng (tránh streak reset chỉ vì sáng nay chưa log).
      DateTime cursor = today;
      bool seenAny = false;
      while (true) {
        final acts = byDay[cursor];
        if (acts == null || acts.isEmpty) {
          // Cho phép skip 1 ngày trống nếu chưa thấy ngày nào — đó là hôm nay.
          if (!seenAny && cursor.isAtSameMomentAs(today)) {
            cursor = cursor.subtract(const Duration(days: 1));
            continue;
          }
          break;
        }
        seenAny = true;
        final score = _scoreOf(acts);
        if (score < _balanceScoreThreshold) break;
        streak++;
        cursor = cursor.subtract(const Duration(days: 1));
      }
      return right(streak);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // ================================ Detox ================================

  @override
  Future<Either<Failure, DetoxSession>> startDetox({
    required int durationDays,
    required int strictness,
    required String reason,
    required List<String> blockedApps,
  }) async {
    try {
      if (localDataSource.getActiveDetoxSession() != null) {
        return left(Failure('Đã có một phiên detox đang chạy'));
      }
      final model = DetoxSessionModel(
        id: _uuid.v4(),
        startTime: DateTime.now(),
        durationDays: durationDays,
        strictness: strictness,
        reason: reason,
        blockedApps: blockedApps,
        isActive: true,
      );
      localDataSource.saveDetoxSession(model);
      return right(model);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetoxSession>> endDetox({required String id}) async {
    try {
      final existing = localDataSource.getDetoxSession(id);
      if (existing == null) {
        return left(Failure('Không tìm thấy phiên detox với id $id'));
      }
      final ended = DetoxSessionModel(
        id: existing.id,
        startTime: existing.startTime,
        durationDays: existing.durationDays,
        strictness: existing.strictness,
        reason: existing.reason,
        blockedApps: existing.blockedApps,
        isActive: false,
        endedAt: DateTime.now(),
      );
      localDataSource.saveDetoxSession(ended);
      return right(ended);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Option<DetoxSession>>> getActiveDetox() async {
    try {
      final session = localDataSource.getActiveDetoxSession();
      return right(Option<DetoxSession>.fromNullable(session));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // ============================ Helpers (private) ============================

  /// Tính score impact cho một activity dựa trên tier × duration.
  /// Đơn vị: 1 phút quy đổi điểm. Cap không cần vì daily score đã clamp 0-100.
  int _calculateScoreImpact(DopamineTier tier, int minutes) {
    return switch (tier) {
      // Cheap: -0.4 / phút (30 phút = -12, 60 phút = -24)
      DopamineTier.cheap => -((minutes * 4) ~/ 10),
      // Medium: -0.1 / phút (mild penalty cho thời gian "trung tính")
      DopamineTier.medium => -(minutes ~/ 10),
      // Healthy: +0.25 / phút (60 phút = +15)
      DopamineTier.healthy => (minutes * 25) ~/ 100,
      // Deep: +0.4 / phút (60 phút = +24)
      DopamineTier.deep => (minutes * 4) ~/ 10,
    };
  }

  int _scoreOf(List<Activity> activities) {
    final delta = activities.fold<int>(0, (sum, a) => sum + a.scoreImpact);
    return (_baseScore + delta).clamp(0, 100);
  }

  DailyScore _buildDailyScore(DateTime day, List<Activity> activities) {
    final minutesByTier = <DopamineTier, int>{
      for (final tier in DopamineTier.values) tier: 0,
    };
    for (final a in activities) {
      minutesByTier[a.tier] = (minutesByTier[a.tier] ?? 0) + a.durationMinutes;
    }
    return DailyScore(
      date: day,
      score: _scoreOf(activities),
      minutesByTier: minutesByTier,
    );
  }
}
