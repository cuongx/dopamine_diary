import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography — Inter qua google_fonts.
/// Chỉ 2 weights: 400 (regular) / 500 (medium). KHÔNG dùng weight >= 600.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _inter({
    required double size,
    required FontWeight weight,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle display = _inter(
    size: 48,
    weight: FontWeight.w500,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static TextStyle heading1 = _inter(
    size: 20,
    weight: FontWeight.w500,
    height: 1.3,
    letterSpacing: -0.2,
  );

  static TextStyle heading2 = _inter(
    size: 17,
    weight: FontWeight.w500,
    height: 1.35,
  );

  static TextStyle body = _inter(
    size: 14,
    weight: FontWeight.w400,
    height: 1.45,
  );

  static TextStyle bodyMedium = _inter(
    size: 14,
    weight: FontWeight.w500,
    height: 1.45,
  );

  static TextStyle label = _inter(
    size: 12,
    weight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.3,
    letterSpacing: 0.1,
  );

  static TextStyle caption = _inter(
    size: 11,
    weight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.3,
  );
}
