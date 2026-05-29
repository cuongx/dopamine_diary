import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/features/diary/data/models/activity_model.dart';
import 'package:dopamine_diary/features/diary/data/models/activity_type_model.dart';
import 'package:dopamine_diary/features/diary/data/models/detox_session_model.dart';
import 'package:hive/hive.dart';

/// Lưu/đọc data dopamine ở Hive 4 local. Không gọi Supabase — MVP hoàn toàn offline.
///
/// Cấu trúc 3 box:
/// - `activities`           : key = activity.id (UUID), value = JSON map
/// - `activity_types`       : key = type.id (seed deterministic / UUID custom)
/// - `detox_sessions`       : key = session.id (UUID)
abstract interface class DopamineLocalDataSource {
  // ============ Activities ============
  void saveActivity(ActivityModel activity);
  List<ActivityModel> getAllActivities();
  void deleteActivity(String id);

  // ============ Activity types ============
  void saveActivityType(ActivityTypeModel type);
  List<ActivityTypeModel> getAllActivityTypes();

  /// Seed 20 activity types mặc định nếu box rỗng (gọi lazy ở repository).
  void seedDefaultActivityTypesIfEmpty();

  // ============ Detox ============
  void saveDetoxSession(DetoxSessionModel session);
  List<DetoxSessionModel> getAllDetoxSessions();
  DetoxSessionModel? getDetoxSession(String id);

  /// Phiên detox đang `isActive == true`. Null nếu không có.
  DetoxSessionModel? getActiveDetoxSession();
}

class DopamineLocalDataSourceImpl implements DopamineLocalDataSource {
  final Box activitiesBox;
  final Box activityTypesBox;
  final Box detoxSessionsBox;

  DopamineLocalDataSourceImpl({
    required this.activitiesBox,
    required this.activityTypesBox,
    required this.detoxSessionsBox,
  });

  // ============================== Activities ==============================

  @override
  void saveActivity(ActivityModel activity) {
    activitiesBox.write(() {
      activitiesBox.put(activity.id, activity.toJson());
    });
  }

  @override
  List<ActivityModel> getAllActivities() {
    final result = <ActivityModel>[];
    activitiesBox.read(() {
      for (final key in activitiesBox.keys) {
        final raw = activitiesBox.get(key);
        if (raw == null) continue;
        result.add(ActivityModel.fromJson(
          Map<String, dynamic>.from(raw as Map),
        ));
      }
    });
    return result;
  }

  @override
  void deleteActivity(String id) {
    activitiesBox.write(() {
      activitiesBox.delete(id);
    });
  }

  // ============================ Activity types ============================

  @override
  void saveActivityType(ActivityTypeModel type) {
    activityTypesBox.write(() {
      activityTypesBox.put(type.id, type.toJson());
    });
  }

  @override
  List<ActivityTypeModel> getAllActivityTypes() {
    final result = <ActivityTypeModel>[];
    activityTypesBox.read(() {
      for (final key in activityTypesBox.keys) {
        final raw = activityTypesBox.get(key);
        if (raw == null) continue;
        result.add(ActivityTypeModel.fromJson(
          Map<String, dynamic>.from(raw as Map),
        ));
      }
    });
    return result;
  }

  @override
  void seedDefaultActivityTypesIfEmpty() {
    if (activityTypesBox.length > 0) return;
    activityTypesBox.write(() {
      for (final seed in _defaultActivityTypes) {
        activityTypesBox.put(seed.id, seed.toJson());
      }
    });
  }

  // =============================== Detox ===============================

  @override
  void saveDetoxSession(DetoxSessionModel session) {
    detoxSessionsBox.write(() {
      detoxSessionsBox.put(session.id, session.toJson());
    });
  }

  @override
  List<DetoxSessionModel> getAllDetoxSessions() {
    final result = <DetoxSessionModel>[];
    detoxSessionsBox.read(() {
      for (final key in detoxSessionsBox.keys) {
        final raw = detoxSessionsBox.get(key);
        if (raw == null) continue;
        result.add(DetoxSessionModel.fromJson(
          Map<String, dynamic>.from(raw as Map),
        ));
      }
    });
    return result;
  }

  @override
  DetoxSessionModel? getDetoxSession(String id) {
    DetoxSessionModel? result;
    detoxSessionsBox.read(() {
      final raw = detoxSessionsBox.get(id);
      if (raw != null) {
        result = DetoxSessionModel.fromJson(
          Map<String, dynamic>.from(raw as Map),
        );
      }
    });
    return result;
  }

  @override
  DetoxSessionModel? getActiveDetoxSession() {
    final all = getAllDetoxSessions();
    for (final session in all) {
      if (session.isActive) return session;
    }
    return null;
  }
}

// =================== Seed data — 20 activity types mặc định ===================

/// 20 activity types user thấy ngay khi mở app lần đầu. Đặt ID dạng
/// `seed_<key>` để dễ trace, user thêm custom sẽ dùng UUID.
const List<ActivityTypeModel> _defaultActivityTypes = [
  // Cheap (5) — dopamine rẻ tiền
  ActivityTypeModel(
    id: 'seed_tiktok',
    name: 'TikTok',
    tier: DopamineTier.cheap,
    iconName: 'video',
  ),
  ActivityTypeModel(
    id: 'seed_ig_reels',
    name: 'Instagram Reels',
    tier: DopamineTier.cheap,
    iconName: 'instagram',
  ),
  ActivityTypeModel(
    id: 'seed_youtube_shorts',
    name: 'YouTube Shorts',
    tier: DopamineTier.cheap,
    iconName: 'youtube',
  ),
  ActivityTypeModel(
    id: 'seed_fb_scroll',
    name: 'Lướt Facebook',
    tier: DopamineTier.cheap,
    iconName: 'facebook',
  ),
  ActivityTypeModel(
    id: 'seed_shopping',
    name: 'Mua sắm online',
    tier: DopamineTier.cheap,
    iconName: 'shopping-cart',
  ),

  // Medium (5) — không tệ không tốt
  ActivityTypeModel(
    id: 'seed_movie',
    name: 'Xem phim',
    tier: DopamineTier.medium,
    iconName: 'film',
  ),
  ActivityTypeModel(
    id: 'seed_series',
    name: 'Xem series',
    tier: DopamineTier.medium,
    iconName: 'tv',
  ),
  ActivityTypeModel(
    id: 'seed_cafe',
    name: 'Cà phê tiệm',
    tier: DopamineTier.medium,
    iconName: 'coffee',
  ),
  ActivityTypeModel(
    id: 'seed_game_casual',
    name: 'Game giải trí',
    tier: DopamineTier.medium,
    iconName: 'gamepad-2',
  ),
  ActivityTypeModel(
    id: 'seed_podcast_fun',
    name: 'Nghe podcast giải trí',
    tier: DopamineTier.medium,
    iconName: 'headphones',
  ),

  // Healthy (5) — lành mạnh
  ActivityTypeModel(
    id: 'seed_walk',
    name: 'Đi bộ',
    tier: DopamineTier.healthy,
    iconName: 'footprints',
  ),
  ActivityTypeModel(
    id: 'seed_gym',
    name: 'Tập gym',
    tier: DopamineTier.healthy,
    iconName: 'dumbbell',
  ),
  ActivityTypeModel(
    id: 'seed_cook',
    name: 'Nấu ăn',
    tier: DopamineTier.healthy,
    iconName: 'chef-hat',
  ),
  ActivityTypeModel(
    id: 'seed_friends',
    name: 'Gặp bạn bè',
    tier: DopamineTier.healthy,
    iconName: 'users',
  ),
  ActivityTypeModel(
    id: 'seed_clean',
    name: 'Dọn nhà',
    tier: DopamineTier.healthy,
    iconName: 'sparkles',
  ),

  // Deep (5) — deep work
  ActivityTypeModel(
    id: 'seed_read',
    name: 'Đọc sách',
    tier: DopamineTier.deep,
    iconName: 'book-open',
  ),
  ActivityTypeModel(
    id: 'seed_code',
    name: 'Lập trình',
    tier: DopamineTier.deep,
    iconName: 'code',
  ),
  ActivityTypeModel(
    id: 'seed_write',
    name: 'Viết lách',
    tier: DopamineTier.deep,
    iconName: 'pen-tool',
  ),
  ActivityTypeModel(
    id: 'seed_study',
    name: 'Học bài',
    tier: DopamineTier.deep,
    iconName: 'graduation-cap',
  ),
  ActivityTypeModel(
    id: 'seed_meditate',
    name: 'Thiền / Yoga',
    tier: DopamineTier.deep,
    iconName: 'brain',
  ),
];
