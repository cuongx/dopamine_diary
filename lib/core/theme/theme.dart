import 'package:dopamine_diary/core/theme/app_colors.dart';
import 'package:dopamine_diary/core/theme/app_radius.dart';
import 'package:dopamine_diary/core/theme/app_spacing.dart';
import 'package:dopamine_diary/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  /// Theme chính cho Dopamine Diary — nền cream, flat, không shadow,
  /// chỉ dùng border 0.5px theo triết lý "anti-engagement design".
  static final lightThemeMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.surface3,
    colorScheme: const ColorScheme.light(
      primary: AppColors.textPrimary,
      onPrimary: AppColors.surface1,
      secondary: AppColors.brandPrimary,
      onSecondary: AppColors.surface1,
      surface: AppColors.surface1,
      onSurface: AppColors.textPrimary,
      error: AppColors.cheapMain,
      onError: AppColors.surface1,
      outline: AppColors.borderDefault,
      outlineVariant: AppColors.borderSubtle,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface3,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: AppTextStyles.heading1,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface1,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.lgR,
        side: const BorderSide(color: AppColors.borderSubtle, width: 0.5),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.borderSubtle,
      thickness: 0.5,
      space: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surface2,
      labelStyle: AppTextStyles.label.copyWith(color: AppColors.textPrimary),
      side: const BorderSide(color: AppColors.borderSubtle, width: 0.5),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space3,
        vertical: AppSpacing.space1,
      ),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.mdR),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface1,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space4,
        vertical: AppSpacing.space3,
      ),
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.textTertiary),
      border: OutlineInputBorder(
        borderRadius: AppRadius.mdR,
        borderSide: const BorderSide(color: AppColors.borderSubtle, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdR,
        borderSide: const BorderSide(color: AppColors.borderSubtle, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdR,
        borderSide: const BorderSide(color: AppColors.textPrimary, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdR,
        borderSide: const BorderSide(color: AppColors.cheapMain, width: 0.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.textPrimary,
        foregroundColor: AppColors.surface1,
        elevation: 0,
        minimumSize: const Size(0, 44),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdR),
        textStyle: AppTextStyles.bodyMedium,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        minimumSize: const Size(0, 44),
        side: const BorderSide(color: AppColors.borderDefault, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdR),
        textStyle: AppTextStyles.bodyMedium,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        minimumSize: const Size(0, 44),
        textStyle: AppTextStyles.bodyMedium,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.display,
      headlineSmall: AppTextStyles.heading1,
      titleMedium: AppTextStyles.heading2,
      bodyMedium: AppTextStyles.body,
      labelLarge: AppTextStyles.bodyMedium,
      labelMedium: AppTextStyles.label,
      labelSmall: AppTextStyles.caption,
    ),
    splashFactory: InkRipple.splashFactory,
    splashColor: AppColors.surface2,
    highlightColor: AppColors.surface2,
  );
}
