import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:flutter/material.dart';

/// Bảng màu Dopamine Diary — 4 tier dopamine + brand + surface + text + border.
/// Theo triết lý "anti-engagement design": nền trung tính, accent chỉ dùng cho data.
class AppColors {
  AppColors._();

  // ============ Tier CHEAP (dopamine rẻ — đỏ) ============
  static const Color cheapBg = Color(0xFFFCEBEB);
  static const Color cheapMain = Color(0xFFE24B4A);
  static const Color cheapFg = Color(0xFF791F1F);
  static const Color cheapText = Color(0xFF501313);

  // ============ Tier MEDIUM (trung bình — vàng/cam) ============
  static const Color mediumBg = Color(0xFFFAEEDA);
  static const Color mediumMain = Color(0xFFEF9F27);
  static const Color mediumFg = Color(0xFF854F0B);
  static const Color mediumText = Color(0xFF412402);

  // ============ Tier HEALTHY (lành mạnh — xanh lá) ============
  static const Color healthyBg = Color(0xFFEAF3DE);
  static const Color healthyMain = Color(0xFF97C459);
  static const Color healthyFg = Color(0xFF27500A);
  static const Color healthyText = Color(0xFF173404);

  // ============ Tier DEEP (deep work — xanh dương) ============
  static const Color deepBg = Color(0xFFE6F1FB);
  static const Color deepMain = Color(0xFF378ADD);
  static const Color deepFg = Color(0xFF0C447C);
  static const Color deepText = Color(0xFF042C53);

  // ============ Brand ============
  static const Color brandPrimary = Color(0xFF534AB7);
  static const Color brandPrimaryBg = Color(0xFFEEEDFE);
  static const Color brandPrimaryText = Color(0xFF26215C);

  static const Color accentCalm = Color(0xFF1D9E75);
  static const Color accentCalmBg = Color(0xFFE1F5EE);
  static const Color accentCalmText = Color(0xFF04342C);

  // ============ Surfaces ============
  static const Color surface1 = Color(0xFFFFFFFF); // card
  static const Color surface2 = Color(0xFFF1EFE8); // subtle bg
  static const Color surface3 = Color(0xFFFAF9F5); // screen bg

  // ============ Text ============
  static const Color textPrimary = Color(0xFF2C2C2A);
  static const Color textSecondary = Color(0xFF5F5E5A);
  static const Color textTertiary = Color(0xFF888780);

  // ============ Border ============
  static const Color borderSubtle = Color(0xFFE8E6DD);
  static const Color borderDefault = Color(0xFFD3D1C7);
}

/// Tiện ích lấy bộ màu theo tier — binding domain enum → UI palette.
/// Enum `DopamineTier` đặt ở core/common/entities (pure Dart, không Flutter).
extension DopamineTierPalette on DopamineTier {
  Color get bg => switch (this) {
        DopamineTier.cheap => AppColors.cheapBg,
        DopamineTier.medium => AppColors.mediumBg,
        DopamineTier.healthy => AppColors.healthyBg,
        DopamineTier.deep => AppColors.deepBg,
      };

  Color get main => switch (this) {
        DopamineTier.cheap => AppColors.cheapMain,
        DopamineTier.medium => AppColors.mediumMain,
        DopamineTier.healthy => AppColors.healthyMain,
        DopamineTier.deep => AppColors.deepMain,
      };

  Color get fg => switch (this) {
        DopamineTier.cheap => AppColors.cheapFg,
        DopamineTier.medium => AppColors.mediumFg,
        DopamineTier.healthy => AppColors.healthyFg,
        DopamineTier.deep => AppColors.deepFg,
      };

  Color get textColor => switch (this) {
        DopamineTier.cheap => AppColors.cheapText,
        DopamineTier.medium => AppColors.mediumText,
        DopamineTier.healthy => AppColors.healthyText,
        DopamineTier.deep => AppColors.deepText,
      };
}
