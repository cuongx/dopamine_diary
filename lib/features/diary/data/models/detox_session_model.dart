import 'package:dopamine_diary/features/diary/domain/entities/detox_session.dart';

/// Model layer cho DetoxSession — serialize qua Hive 4.
class DetoxSessionModel extends DetoxSession {
  const DetoxSessionModel({
    required super.id,
    required super.startTime,
    required super.durationDays,
    required super.strictness,
    required super.reason,
    required super.blockedApps,
    required super.isActive,
    super.endedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'start_time': startTime.toIso8601String(),
      'duration_days': durationDays,
      'strictness': strictness,
      'reason': reason,
      'blocked_apps': blockedApps,
      'is_active': isActive,
      'ended_at': endedAt?.toIso8601String(),
    };
  }

  factory DetoxSessionModel.fromJson(Map<String, dynamic> map) {
    return DetoxSessionModel(
      id: map['id'] as String,
      startTime: DateTime.parse(map['start_time'] as String),
      durationDays: map['duration_days'] as int,
      strictness: map['strictness'] as int,
      reason: map['reason'] as String,
      blockedApps: List<String>.from(map['blocked_apps'] as List? ?? const []),
      isActive: map['is_active'] as bool,
      endedAt: map['ended_at'] == null
          ? null
          : DateTime.parse(map['ended_at'] as String),
    );
  }

  factory DetoxSessionModel.fromEntity(DetoxSession session) {
    return DetoxSessionModel(
      id: session.id,
      startTime: session.startTime,
      durationDays: session.durationDays,
      strictness: session.strictness,
      reason: session.reason,
      blockedApps: session.blockedApps,
      isActive: session.isActive,
      endedAt: session.endedAt,
    );
  }
}
