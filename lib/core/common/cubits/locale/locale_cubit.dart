import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

/// Quản lý locale của app (vi / en). `null` = follow system.
///
/// Persist qua Hive box `settings` (key 'locale'). Khởi tạo:
/// - Đọc giá trị đã save (vi/en) → dùng locale đó
/// - Nếu chưa save → emit `null` để MaterialApp follow device locale
class LocaleCubit extends Cubit<Locale?> {
  static const _boxName = 'settings';
  static const _key = 'locale';

  LocaleCubit() : super(_readInitial());

  static Locale? _readInitial() {
    final box = Hive.box(name: _boxName);
    final stored = box.get(_key);
    if (stored is String && (stored == 'vi' || stored == 'en')) {
      return Locale(stored);
    }
    return null;
  }

  /// Đổi sang locale `code` ('vi'/'en'), hoặc `null` để follow system.
  void setLocale(String? code) {
    final box = Hive.box(name: _boxName);
    if (code == null) {
      box.delete(_key);
      emit(null);
    } else {
      box.put(_key, code);
      emit(Locale(code));
    }
  }
}
