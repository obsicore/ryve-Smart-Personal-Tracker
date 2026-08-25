import 'package:flutter/material.dart';

/// Selectable-theme record shape mirroring `AppThemeRecord` without a
/// dependency on the Drift-generated database class (keeps this file free
/// of database imports).
class ThemeColorSet {
  const ThemeColorSet({
    required this.id,
    required this.primary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.isDark,
  });

  final String id;
  final Color primary;
  final Color accent;
  final Color background;
  final Color surface;
  final bool isDark;
}

class AppColors {
  // Dark palette — mutable (not `const`) so `applyTheme` can re-skin the app
  // at runtime when the user picks one of the seeded `app_themes` rows. Every
  // field keeps its original default value, so the app looks identical to
  // before this became configurable until a theme is actively selected.
  static Color darkBackground     = const Color(0xFF0D1F17);
  static Color darkSurface        = const Color(0xFF152B1E);
  static Color darkSurfaceVariant = const Color(0xFF1E3828);
  static Color darkSurfaceBright  = const Color(0xFF253F2F);
  static Color darkPrimary        = const Color(0xFFC9A84C);
  static Color darkPrimaryVariant = const Color(0xFFE8C46A);
  static Color darkSecondary      = const Color(0xFF4CAF82);
  static Color darkTertiary       = const Color(0xFF7BC4A0);
  static Color darkOnBackground   = const Color(0xFFF0EBE0);
  static Color darkOnSurface      = const Color(0xFFDAD5CA);
  static Color darkOnSurfaceMuted = const Color(0xFF8A9E92);
  static Color darkOnPrimary      = const Color(0xFF0D1F17);

  // Light palette — same mutability rationale as above.
  static Color lightBackground     = const Color(0xFFF0EBE0);
  static Color lightSurface        = const Color(0xFFFFFFFF);
  static Color lightSurfaceVariant = const Color(0xFFF5F0E8);
  static Color lightSurfaceBright  = const Color(0xFFE8F0EB);
  static Color lightPrimary        = const Color(0xFF1A3528);
  static Color lightPrimaryVariant = const Color(0xFF2A4F3C);
  static Color lightSecondary      = const Color(0xFF2E7D32);
  static Color lightTertiary       = const Color(0xFF4CAF82);
  static Color lightOnBackground   = const Color(0xFF0D1F17);
  static Color lightOnSurface      = const Color(0xFF2A3C32);
  static Color lightOnSurfaceMuted = const Color(0xFF6B8275);
  static Color lightOnPrimary      = const Color(0xFFF0EBE0);
  static Color lightAccent         = const Color(0xFFC9A84C);

  /// Re-skins the brand palette for whichever brightness [theme] targets,
  /// deriving the handful of colors it doesn't specify (surfaceVariant,
  /// onSurface, etc.) proportionally from the existing default relationship
  /// between primary/background and those derived tones, so every custom
  /// theme still has readable contrast without needing 12 hex fields each.
  /// Pass `null` to restore the built-in Forest Dark / matching light defaults.
  static void applyTheme(ThemeColorSet? theme) {
    if (theme == null) {
      _resetDefaults();
      return;
    }
    if (theme.isDark) {
      darkBackground = theme.background;
      darkSurface = theme.surface;
      darkSurfaceVariant = Color.lerp(theme.surface, theme.background, 0.4)!;
      darkSurfaceBright = Color.lerp(theme.surface, theme.accent, 0.15)!;
      darkPrimary = theme.primary;
      darkPrimaryVariant = Color.lerp(theme.primary, Colors.white, 0.2)!;
      darkSecondary = theme.accent;
      darkTertiary = Color.lerp(theme.accent, Colors.white, 0.25)!;
      darkOnPrimary = _readableOn(theme.primary);
    } else {
      lightBackground = theme.background;
      lightSurface = theme.surface;
      lightSurfaceVariant = Color.lerp(theme.surface, theme.background, 0.3)!;
      lightSurfaceBright = Color.lerp(theme.surface, theme.accent, 0.1)!;
      lightPrimary = theme.primary;
      lightPrimaryVariant = Color.lerp(theme.primary, Colors.black, 0.15)!;
      lightSecondary = theme.accent;
      lightTertiary = Color.lerp(theme.accent, Colors.black, 0.1)!;
      lightAccent = theme.accent;
      lightOnPrimary = _readableOn(theme.primary);
    }
  }

  static Color _readableOn(Color background) =>
      background.computeLuminance() > 0.4 ? const Color(0xFF0D1F17) : const Color(0xFFF0EBE0);

  static void _resetDefaults() {
    darkBackground = const Color(0xFF0D1F17);
    darkSurface = const Color(0xFF152B1E);
    darkSurfaceVariant = const Color(0xFF1E3828);
    darkSurfaceBright = const Color(0xFF253F2F);
    darkPrimary = const Color(0xFFC9A84C);
    darkPrimaryVariant = const Color(0xFFE8C46A);
    darkSecondary = const Color(0xFF4CAF82);
    darkTertiary = const Color(0xFF7BC4A0);
    darkOnPrimary = const Color(0xFF0D1F17);
    lightBackground = const Color(0xFFF0EBE0);
    lightSurface = const Color(0xFFFFFFFF);
    lightSurfaceVariant = const Color(0xFFF5F0E8);
    lightSurfaceBright = const Color(0xFFE8F0EB);
    lightPrimary = const Color(0xFF1A3528);
    lightPrimaryVariant = const Color(0xFF2A4F3C);
    lightSecondary = const Color(0xFF2E7D32);
    lightTertiary = const Color(0xFF4CAF82);
    lightAccent = const Color(0xFFC9A84C);
    lightOnPrimary = const Color(0xFFF0EBE0);
  }

  // Shared
  static const error          = Color(0xFFE57373);
  static const warning        = Color(0xFFFFB74D);
  static const info           = Color(0xFF64B5F6);
  static const success        = Color(0xFF66BB6A);
  static const priorityUrgent = Color(0xFFE57373);
  static const priorityHigh   = Color(0xFFFFB74D);
  static const priorityMed    = Color(0xFF64B5F6);
  static const priorityLow    = Color(0xFF8A9E92);

  static const moodColors = [
    Color(0xFFE57373),
    Color(0xFFEF9A9A),
    Color(0xFFFFCC02),
    Color(0xFFFFB74D),
    Color(0xFFFFCC80),
    Color(0xFFA5D6A7),
    Color(0xFF66BB6A),
    Color(0xFF4CAF50),
    Color(0xFF43A047),
    Color(0xFF2E7D32),
  ];
}
