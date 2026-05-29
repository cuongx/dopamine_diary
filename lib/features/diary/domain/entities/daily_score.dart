import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:equatable/equatable.dart';

/// Tổng kết dopamine một ngày: điểm tổng 0-100 + số phút mỗi tier.
///
/// Dùng cho Home (score ring + tier bar) và Analytics (bar chart 7 ngày).
class DailyScore extends Equatable {
  final DateTime date;
  final int score;
  final Map<DopamineTier, int> minutesByTier;

  const DailyScore({
    required this.date,
    required this.score,
    required this.minutesByTier,
  });

  /// Tổng số phút đã log trong ngày.
  int get totalMinutes =>
      minutesByTier.values.fold(0, (sum, m) => sum + m);

  /// Tỉ lệ phần trăm thời gian của một tier trong ngày. Trả 0.0 nếu rỗng.
  double percentOf(DopamineTier tier) {
    final total = totalMinutes;
    if (total == 0) return 0;
    return (minutesByTier[tier] ?? 0) / total;
  }

  /// So sánh với hôm trước — `score - previous.score`. 0 nếu null.
  int deltaFrom(DailyScore? previous) {
    if (previous == null) return 0;
    return score - previous.score;
  }

  DailyScore copyWith({
    DateTime? date,
    int? score,
    Map<DopamineTier, int>? minutesByTier,
  }) {
    return DailyScore(
      date: date ?? this.date,
      score: score ?? this.score,
      minutesByTier: minutesByTier ?? this.minutesByTier,
    );
  }

  @override
  List<Object?> get props => [date, score, minutesByTier];
}
