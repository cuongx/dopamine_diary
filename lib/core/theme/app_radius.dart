import 'package:flutter/material.dart';

/// Bán kính bo tròn — chỉ 4 mức.
class AppRadius {
  AppRadius._();

  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 28;

  static BorderRadius get smR => BorderRadius.circular(sm);
  static BorderRadius get mdR => BorderRadius.circular(md);
  static BorderRadius get lgR => BorderRadius.circular(lg);
  static BorderRadius get xlR => BorderRadius.circular(xl);
}
