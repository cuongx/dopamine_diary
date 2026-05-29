import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/core/error/failures.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';
import 'package:dopamine_diary/features/diary/domain/entities/daily_score.dart';
import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';
import 'package:fpdart/fpdart.dart';

/// Hợp đồng repository cho mọi thao tác liên quan dopamine.
/// Triển khai sẽ ở data layer (Hive 4 local-only cho MVP).
///
/// Lưu ý: đặt tên `DopamineRepository` để phân biệt với `DiaryRepository`
/// (legacy blog repository). Cùng nằm trong feature `diary` nhưng phục vụ
/// 2 domain khác nhau.
abstract interface class DopamineRepository {
  // ============ Activity ============

  /// Lưu một lần log hoạt động. Repository tự tính `scoreImpact`.
  Future<Either<Failure, Activity>> logActivity({
    required String name,
    required DopamineTier tier,
    required int durationMinutes,
    String? mood,
  });

  /// Lấy activities trong khoảng [from, to). Mặc định dùng cho "hôm nay".
  Future<Either<Failure, List<Activity>>> getActivitiesBetween({
    required DateTime from,
    required DateTime to,
  });

  /// Lấy n activities mới nhất (cho Home recent + Quick Log gợi ý).
  Future<Either<Failure, List<Activity>>> getRecentActivities({int limit = 10});

  // ============ Activity types (template user phân loại) ============

  /// Danh sách activity types user đang có (built-in + custom).
  Future<Either<Failure, List<ActivityType>>> getActivityTypes();

  /// Tạo activity type mới do user thêm.
  Future<Either<Failure, ActivityType>> createActivityType({
    required String name,
    required DopamineTier tier,
    required String iconName,
  });

  /// User reclassify một activity type sang tier khác
  /// (vì TikTok với creator là công việc thật).
  Future<Either<Failure, ActivityType>> classifyActivityType({
    required String typeId,
    required DopamineTier newTier,
  });

  // ============ Score & analytics ============

  /// Score tổng kết một ngày.
  Future<Either<Failure, DailyScore>> getDailyScore(DateTime date);

  /// Score 7 ngày gần nhất (cho Home delta + Analytics bar chart).
  Future<Either<Failure, List<DailyScore>>> getWeeklyScores();

  /// Đếm streak ngày liên tiếp đạt ngưỡng "cân bằng" (score >= threshold).
  Future<Either<Failure, int>> getCurrentStreak();

  // ============ Detox ============

  /// Bắt đầu một phiên detox. Trả Failure nếu đã có phiên active.
  Future<Either<Failure, DetoxSession>> startDetox({
    required int durationDays,
    required int strictness,
    required String reason,
    required List<String> blockedApps,
  });

  /// Kết thúc phiên detox đang chạy (sớm hoặc khi hết hạn).
  Future<Either<Failure, DetoxSession>> endDetox({required String id});

  /// Phiên detox đang chạy. Trả `None` nếu không có.
  Future<Either<Failure, Option<DetoxSession>>> getActiveDetox();
}
