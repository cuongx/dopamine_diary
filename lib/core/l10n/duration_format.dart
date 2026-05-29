import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// Format thời lượng (phút) thành chuỗi ngắn theo locale.
/// - vi: 5p / 30p / 1h / 1h30p
/// - en: 5m / 30m / 1h / 1h30m
String formatMinutes(BuildContext context, int minutes) {
  final l10n = AppLocalizations.of(context);
  if (minutes < 60) return l10n.durationMinutes(minutes);
  final h = minutes ~/ 60;
  final m = minutes % 60;
  if (m == 0) return l10n.durationHours(h);
  return l10n.durationHoursMinutes(h, m);
}

/// Format thời lượng dài (cho phép 0p): luôn trả non-empty.
String formatMinutesAllowZero(BuildContext context, int minutes) {
  if (minutes <= 0) {
    return AppLocalizations.of(context).durationMinutes(0);
  }
  return formatMinutes(context, minutes);
}

/// Format `Duration` còn lại của detox: ưu tiên ngày/giờ.
/// - Dùng ở Home detox banner và Detox running view.
String formatRemainingDays(BuildContext context, Duration d) {
  final l10n = AppLocalizations.of(context);
  if (d.isNegative) return l10n.homeDetoxExpired;
  final days = d.inDays;
  final hours = d.inHours % 24;
  if (days > 0) return l10n.durationDaysHoursShort(days, hours);
  final mins = d.inMinutes % 60;
  if (hours > 0) return l10n.durationHoursMinShort(hours, mins);
  return l10n.durationMinutes(mins);
}
