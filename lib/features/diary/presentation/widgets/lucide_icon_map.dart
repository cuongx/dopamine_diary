import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Map từ `ActivityType.iconName` (string lưu trong Hive) → `IconData` lucide.
///
/// Tách ra để widget render activity không hardcode IconData từng cái —
/// chỉ cần truyền tên string đã lưu trong model.
class LucideIconMap {
  LucideIconMap._();

  static IconData of(String name) => _map[name] ?? LucideIcons.circle;

  static const Map<String, IconData> _map = {
    // Cheap
    'video': LucideIcons.video,
    'instagram': LucideIcons.instagram,
    'youtube': LucideIcons.youtube,
    'facebook': LucideIcons.facebook,
    'shopping-cart': LucideIcons.shoppingCart,
    // Medium
    'film': LucideIcons.film,
    'tv': LucideIcons.tv,
    'coffee': LucideIcons.coffee,
    'gamepad-2': LucideIcons.gamepad2,
    'headphones': LucideIcons.headphones,
    // Healthy
    'footprints': LucideIcons.footprints,
    'dumbbell': LucideIcons.dumbbell,
    'chef-hat': LucideIcons.chefHat,
    'users': LucideIcons.users,
    'sparkles': LucideIcons.sparkles,
    // Deep
    'book-open': LucideIcons.bookOpen,
    'code': LucideIcons.code,
    'pen-tool': LucideIcons.penTool,
    'graduation-cap': LucideIcons.graduationCap,
    'brain': LucideIcons.brain,
  };
}
