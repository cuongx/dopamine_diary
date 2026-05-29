import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity.dart';

/// Model layer cho Activity — extends entity, thêm `toJson/fromJson`
/// để serialize qua Hive 4 (lưu dưới dạng `Map<String, dynamic>`).
class ActivityModel extends Activity {
  const ActivityModel({
    required super.id,
    required super.name,
    required super.tier,
    required super.durationMinutes,
    required super.timestamp,
    required super.scoreImpact,
    super.mood,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'tier': tier.key,
      'duration_minutes': durationMinutes,
      'timestamp': timestamp.toIso8601String(),
      'mood': mood,
      'score_impact': scoreImpact,
    };
  }

  factory ActivityModel.fromJson(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'] as String,
      name: map['name'] as String,
      tier: DopamineTierLabel.fromKey(map['tier'] as String),
      durationMinutes: map['duration_minutes'] as int,
      timestamp: DateTime.parse(map['timestamp'] as String),
      mood: map['mood'] as String?,
      scoreImpact: map['score_impact'] as int,
    );
  }

  /// Tạo model từ entity (dùng khi repo nhận entity và muốn lưu xuống Hive).
  factory ActivityModel.fromEntity(Activity activity) {
    return ActivityModel(
      id: activity.id,
      name: activity.name,
      tier: activity.tier,
      durationMinutes: activity.durationMinutes,
      timestamp: activity.timestamp,
      mood: activity.mood,
      scoreImpact: activity.scoreImpact,
    );
  }
}
