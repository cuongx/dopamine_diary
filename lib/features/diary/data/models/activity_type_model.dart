import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/features/diary/domain/entities/activity_type.dart';

/// Model layer cho ActivityType — serialize qua Hive 4.
class ActivityTypeModel extends ActivityType {
  const ActivityTypeModel({
    required super.id,
    required super.name,
    required super.tier,
    required super.iconName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'tier': tier.key,
      'icon_name': iconName,
    };
  }

  factory ActivityTypeModel.fromJson(Map<String, dynamic> map) {
    return ActivityTypeModel(
      id: map['id'] as String,
      name: map['name'] as String,
      tier: DopamineTierLabel.fromKey(map['tier'] as String),
      iconName: map['icon_name'] as String,
    );
  }

  factory ActivityTypeModel.fromEntity(ActivityType type) {
    return ActivityTypeModel(
      id: type.id,
      name: type.name,
      tier: type.tier,
      iconName: type.iconName,
    );
  }
}
