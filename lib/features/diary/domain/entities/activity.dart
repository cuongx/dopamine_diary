import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:equatable/equatable.dart';

/// Một lần user log lại hoạt động vừa làm.
///
/// `scoreImpact` là điểm ảnh hưởng tới điểm dopamine hằng ngày, tính bởi
/// repository khi log (tier × duration × hệ số). Pure Dart, không phụ thuộc Flutter.
class Activity extends Equatable {
  final String id;
  final String name;
  final DopamineTier tier;
  final int durationMinutes;
  final DateTime timestamp;

  /// Emoji mood lúc log, ví dụ '😊', '😔'. Optional.
  final String? mood;

  /// Điểm ảnh hưởng tới daily score, ví dụ -12 (cheap dài), +18 (deep work).
  final int scoreImpact;

  const Activity({
    required this.id,
    required this.name,
    required this.tier,
    required this.durationMinutes,
    required this.timestamp,
    required this.scoreImpact,
    this.mood,
  });

  Activity copyWith({
    String? id,
    String? name,
    DopamineTier? tier,
    int? durationMinutes,
    DateTime? timestamp,
    String? mood,
    int? scoreImpact,
  }) {
    return Activity(
      id: id ?? this.id,
      name: name ?? this.name,
      tier: tier ?? this.tier,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      timestamp: timestamp ?? this.timestamp,
      mood: mood ?? this.mood,
      scoreImpact: scoreImpact ?? this.scoreImpact,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        tier,
        durationMinutes,
        timestamp,
        mood,
        scoreImpact,
      ];
}
