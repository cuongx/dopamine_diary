import 'package:dopamine_diary/core/common/entities/dopamine_tier.dart';
import 'package:dopamine_diary/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// Trả về nhãn tier theo locale hiện tại của app.
/// Đặt ở core/l10n để các layer presentation cùng dùng.
extension DopamineTierLocalizedLabel on DopamineTier {
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (this) {
      DopamineTier.cheap => l10n.tierCheap,
      DopamineTier.medium => l10n.tierMedium,
      DopamineTier.healthy => l10n.tierHealthy,
      DopamineTier.deep => l10n.tierDeep,
    };
  }
}
