import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';

/// Kết quả parse transcript → activity có cấu trúc.
class ParsedActivity {
  final String name;
  final DopamineTier tier;
  final int durationMinutes;
  final String mood;

  const ParsedActivity({
    required this.name,
    required this.tier,
    required this.durationMinutes,
    required this.mood,
  });
}

/// Parser cục bộ (rule-based) — MIỄN PHÍ, offline, tức thì. Không gọi API.
/// Dùng regex bắt thời lượng + từ khoá phân tier. Hỗ trợ cả tiếng Việt lẫn
/// Anh (kèm biến thể không dấu). Kém thông minh hơn AI nhưng đủ cho câu rõ ràng.
class VoiceParseService {
  const VoiceParseService();

  ParsedActivity parse({required String transcript, required String localeCode}) {
    final raw = transcript.trim();
    final t = raw.toLowerCase();
    return ParsedActivity(
      name: raw.isEmpty ? '—' : raw,
      tier: _classifyTier(t),
      durationMinutes: _extractMinutes(t),
      mood: _detectMood(t),
    );
  }

  // ---------- Thời lượng (phút) ----------

  int _extractMinutes(String t) {
    var total = 0;

    // "nửa tiếng" / "nửa giờ" / "half an hour" → 30
    if (RegExp(r'(nửa|nua)\s*(tiếng|tieng|giờ|gio)').hasMatch(t) ||
        RegExp(r'half\s*(an\s*)?hour').hasMatch(t)) {
      total += 30;
    }

    // Giờ: "2 giờ", "1.5 tiếng", "2h", "3 hours"
    final hour = RegExp(r'(\d+(?:[.,]\d+)?)\s*(tiếng|tieng|giờ|gio|hours?|hrs?|h)\b')
        .firstMatch(t);
    if (hour != null) {
      final v = double.tryParse(hour.group(1)!.replaceAll(',', '.')) ?? 0;
      total += (v * 60).round();
      // "1 tiếng rưỡi" → +30
      if (RegExp(r'(rưỡi|ruoi)').hasMatch(t)) total += 30;
    }

    // Phút: "30 phút", "45 min", "20 minutes", "15m"
    final min = RegExp(r'(\d+)\s*(phút|phut|minutes|minute|mins|min|m)\b')
        .firstMatch(t);
    if (min != null) {
      total += int.tryParse(min.group(1)!) ?? 0;
    }

    return total;
  }

  // ---------- Phân tier theo từ khoá ----------

  static const Map<DopamineTier, List<String>> _keywords = {
    DopamineTier.cheap: [
      'tiktok', 'reels', 'reel', 'facebook', 'fb', 'instagram', 'insta',
      'lướt', 'luot', 'scroll', 'doomscroll', 'short', 'shorts',
      'mạng xã hội', 'mang xa hoi', 'mxh', 'newsfeed', 'feed',
    ],
    DopamineTier.medium: [
      'phim', 'movie', 'netflix', 'series', 'nhạc', 'nhac', 'music',
      'game', 'chơi game', 'choi game', 'ăn vặt', 'an vat', 'snack',
      'xã giao', 'xa giao', 'tán gẫu', 'tan gau', 'youtube',
    ],
    DopamineTier.healthy: [
      'chạy', 'chay', 'đi bộ', 'di bo', 'gym', 'tập', 'tap', 'thể dục',
      'the duc', 'nấu', 'nau', 'cook', 'run', 'walk', 'walking',
      'exercise', 'workout', 'yoga', 'bơi', 'boi', 'swim', 'gặp bạn', 'gap ban',
    ],
    DopamineTier.deep: [
      'đọc', 'doc', 'sách', 'sach', 'học', 'hoc', 'code', 'coding',
      'lập trình', 'lap trinh', 'viết', 'viet', 'thiền', 'thien',
      'read', 'study', 'write', 'writing', 'meditate', 'meditation',
      'deep work', 'làm việc', 'lam viec', 'ôn', 'on tap',
    ],
  };

  DopamineTier _classifyTier(String t) {
    var best = DopamineTier.medium;
    var bestCount = 0;
    // Ưu tiên khi hoà: deep > healthy > cheap > medium (thứ tự duyệt).
    for (final tier in [
      DopamineTier.deep,
      DopamineTier.healthy,
      DopamineTier.cheap,
      DopamineTier.medium,
    ]) {
      final count = _keywords[tier]!.where((kw) => t.contains(kw)).length;
      if (count > bestCount) {
        bestCount = count;
        best = tier;
      }
    }
    return best;
  }

  // ---------- Cảm xúc (emoji) ----------

  static const List<String> _positive = [
    'vui', 'tốt', 'tot', 'ổn', 'on', 'thích', 'thich', 'tuyệt', 'tuyet',
    'hạnh phúc', 'hanh phuc', 'happy', 'good', 'great', 'productive', 'nice',
  ];
  static const List<String> _negative = [
    'mệt', 'met', 'chán', 'chan', 'buồn', 'buon', 'tệ', 'te', 'stress',
    'tired', 'bored', 'sad', 'bad', 'lo', 'lo lắng', 'lo lang',
  ];

  String _detectMood(String t) {
    if (_negative.any((w) => t.contains(w))) return '😞';
    if (_positive.any((w) => t.contains(w))) return '😊';
    return '🙂';
  }
}
