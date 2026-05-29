import 'package:equatable/equatable.dart';

/// Một phiên detox của user. Chỉ có tối đa 1 phiên active tại một thời điểm.
///
/// `strictness` 1 (nhẹ) / 2 (vừa) / 3 (cứng) ảnh hưởng tới việc app nhắc nhở.
/// `reason` là lý do user viết khi setup — dùng remind khi muốn relapse.
class DetoxSession extends Equatable {
  final String id;
  final DateTime startTime;
  final int durationDays;
  final int strictness;
  final String reason;
  final List<String> blockedApps;
  final bool isActive;

  /// Thời điểm kết thúc thực tế — null nếu chưa kết thúc.
  final DateTime? endedAt;

  const DetoxSession({
    required this.id,
    required this.startTime,
    required this.durationDays,
    required this.strictness,
    required this.reason,
    required this.blockedApps,
    required this.isActive,
    this.endedAt,
  });

  /// Thời điểm kết thúc dự kiến.
  DateTime get expectedEndTime =>
      startTime.add(Duration(days: durationDays));

  /// Thời gian còn lại tính từ thời điểm hiện tại. Negative = đã hết hạn.
  Duration remainingFrom(DateTime now) => expectedEndTime.difference(now);

  DetoxSession copyWith({
    String? id,
    DateTime? startTime,
    int? durationDays,
    int? strictness,
    String? reason,
    List<String>? blockedApps,
    bool? isActive,
    DateTime? endedAt,
  }) {
    return DetoxSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      durationDays: durationDays ?? this.durationDays,
      strictness: strictness ?? this.strictness,
      reason: reason ?? this.reason,
      blockedApps: blockedApps ?? this.blockedApps,
      isActive: isActive ?? this.isActive,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        startTime,
        durationDays,
        strictness,
        reason,
        blockedApps,
        isActive,
        endedAt,
      ];
}
