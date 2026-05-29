/// 4 tier dopamine — khái niệm cốt lõi của app, dùng xuyên suốt
/// domain/data/presentation. Đặt ở core để mọi layer cùng import được
/// mà không phá vỡ Clean Architecture.
enum DopamineTier {
  /// Dopamine rẻ tiền — TikTok, Reels, lướt mạng vô thức.
  cheap,

  /// Trung bình — xem phim, ăn vặt, gặp bạn xã giao.
  medium,

  /// Lành mạnh — tập thể dục, đi bộ, gặp bạn thân, nấu ăn.
  healthy,

  /// Deep work — đọc sách, học, code, viết, meditate.
  deep,
}

extension DopamineTierLabel on DopamineTier {
  /// Nhãn tiếng Việt hiển thị cho user.
  String get vietnameseLabel => switch (this) {
        DopamineTier.cheap => 'Rẻ tiền',
        DopamineTier.medium => 'Trung bình',
        DopamineTier.healthy => 'Lành mạnh',
        DopamineTier.deep => 'Deep work',
      };

  /// Key chuỗi để serialize (an toàn khi đổi thứ tự enum).
  String get key => switch (this) {
        DopamineTier.cheap => 'cheap',
        DopamineTier.medium => 'medium',
        DopamineTier.healthy => 'healthy',
        DopamineTier.deep => 'deep',
      };

  /// Parse từ key chuỗi → enum, fallback về medium nếu không match.
  static DopamineTier fromKey(String key) => switch (key) {
        'cheap' => DopamineTier.cheap,
        'medium' => DopamineTier.medium,
        'healthy' => DopamineTier.healthy,
        'deep' => DopamineTier.deep,
        _ => DopamineTier.medium,
      };
}
