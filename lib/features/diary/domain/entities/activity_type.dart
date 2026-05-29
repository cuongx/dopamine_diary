import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:equatable/equatable.dart';

/// Template hoạt động — user tự phân loại tier khi onboarding hoặc
/// chỉnh lại sau (TikTok với creator có thể là healthy/deep work).
///
/// `iconName` là tên icon lucide (xem package lucide_icons), ví dụ
/// 'video', 'book', 'dumbbell', 'coffee'. Pure Dart, không phụ thuộc Flutter.
class ActivityType extends Equatable {
  final String id;
  final String name;
  final DopamineTier tier;
  final String iconName;

  const ActivityType({
    required this.id,
    required this.name,
    required this.tier,
    required this.iconName,
  });

  ActivityType copyWith({
    String? id,
    String? name,
    DopamineTier? tier,
    String? iconName,
  }) {
    return ActivityType(
      id: id ?? this.id,
      name: name ?? this.name,
      tier: tier ?? this.tier,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  List<Object?> get props => [id, name, tier, iconName];
}
