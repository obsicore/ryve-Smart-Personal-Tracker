import 'package:flutter/material.dart';

class AppShadows {
  static List<BoxShadow> card = [
    BoxShadow(
      color: const Color(0xFF0D1F17).withOpacity(0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: const Color(0xFF0D1F17).withOpacity(0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> modal = [
    BoxShadow(
      color: const Color(0xFF0D1F17).withOpacity(0.16),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: const Color(0xFF0D1F17).withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> fab = [
    BoxShadow(
      color: const Color(0xFFC9A84C).withOpacity(0.32),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}
