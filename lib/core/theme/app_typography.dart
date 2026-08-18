import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextStyle displayLarge(Color color) => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: color,
      );

  static TextStyle displayMedium(Color color) => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: color,
      );

  static TextStyle headlineLarge(Color color) => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      );

  static TextStyle headlineMedium(Color color) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: color,
      );

  static TextStyle titleLarge(Color color) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: color,
      );

  static TextStyle titleMedium(Color color) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: color,
      );

  static TextStyle bodyLarge(Color color) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      );

  static TextStyle bodyMedium(Color color) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      );

  static TextStyle bodySmall(Color color) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      );

  static TextStyle labelLarge(Color color) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: 0.5,
        color: color,
      );

  static TextStyle labelMedium(Color color) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: 0.5,
        color: color,
      );

  static TextStyle labelSmall(Color color) => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 0.8,
        color: color,
      );

  static TextTheme textTheme(Color onBackground, Color onSurface, Color muted) {
    return TextTheme(
      displayLarge:  displayLarge(onBackground),
      displayMedium: displayMedium(onBackground),
      headlineLarge: headlineLarge(onBackground),
      headlineMedium: headlineMedium(onBackground),
      titleLarge:    titleLarge(onSurface),
      titleMedium:   titleMedium(onSurface),
      bodyLarge:     bodyLarge(onSurface),
      bodyMedium:    bodyMedium(onSurface),
      bodySmall:     bodySmall(muted),
      labelLarge:    labelLarge(onSurface),
      labelMedium:   labelMedium(muted),
      labelSmall:    labelSmall(muted),
    );
  }
}
