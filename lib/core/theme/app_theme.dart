import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';

class AppTheme {
  static ThemeData get dark => _build(Brightness.dark);
  static ThemeData get light => _build(Brightness.light);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final background     = isDark ? AppColors.darkBackground     : AppColors.lightBackground;
    final surface        = isDark ? AppColors.darkSurface        : AppColors.lightSurface;
    final surfaceVariant = isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
    final surfaceBright  = isDark ? AppColors.darkSurfaceBright  : AppColors.lightSurfaceBright;
    final primary        = isDark ? AppColors.darkPrimary        : AppColors.lightPrimary;
    final primaryVariant = isDark ? AppColors.darkPrimaryVariant : AppColors.lightPrimaryVariant;
    final secondary      = isDark ? AppColors.darkSecondary      : AppColors.lightSecondary;
    final onBackground   = isDark ? AppColors.darkOnBackground   : AppColors.lightOnBackground;
    final onSurface      = isDark ? AppColors.darkOnSurface      : AppColors.lightOnSurface;
    final onSurfaceMuted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final onPrimary      = isDark ? AppColors.darkOnPrimary      : AppColors.lightOnPrimary;

    final colorScheme = ColorScheme(
      brightness:       brightness,
      primary:          primary,
      onPrimary:        onPrimary,
      primaryContainer: primaryVariant,
      onPrimaryContainer: onSurface,
      secondary:        secondary,
      onSecondary:      isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
      secondaryContainer: surfaceVariant,
      onSecondaryContainer: onSurface,
      tertiary:         isDark ? AppColors.darkTertiary : AppColors.lightTertiary,
      onTertiary:       onPrimary,
      error:            AppColors.error,
      onError:          Colors.white,
      surface:          surface,
      onSurface:        onSurface,
      surfaceContainerHighest: surfaceVariant,
      outline:          onSurfaceMuted.withOpacity(0.3),
      outlineVariant:   onSurfaceMuted.withOpacity(0.15),
      shadow:           isDark ? Colors.black : const Color(0xFF0D1F17),
      scrim:            Colors.black54,
    );

    final systemOverlayStyle = isDark
        ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: AppColors.darkBackground,
          )
        : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: AppColors.lightBackground,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: AppTypography.textTheme(onBackground, onSurface, onSurfaceMuted),

      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: onBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: systemOverlayStyle,
        titleTextStyle: AppTypography.titleLarge(onBackground),
        iconTheme: IconThemeData(color: onSurface),
        actionsIconTheme: IconThemeData(color: onSurface),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          // Subtle border in dark keeps cards legible without elevation
          side: isDark
              ? BorderSide(color: surfaceBright, width: 1)
              : BorderSide.none,
        ),
        margin: EdgeInsets.zero,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
          foregroundColor: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          elevation: 0,
          textStyle: AppTypography.labelLarge(Colors.transparent).copyWith(inherit: false,
            fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          side: BorderSide(color: primary, width: 1.5),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceBright,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        hintStyle: AppTypography.bodyMedium(onSurfaceMuted),
        labelStyle: AppTypography.bodyMedium(onSurfaceMuted),
        floatingLabelStyle: AppTypography.labelMedium(primary),
        errorStyle: AppTypography.bodySmall(AppColors.error),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: onSurfaceMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.labelSmall(primary),
        unselectedLabelStyle: AppTypography.labelSmall(onSurfaceMuted),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primary.withOpacity(0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: primary);
          }
          return IconThemeData(color: onSurfaceMuted);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.labelSmall(primary);
          }
          return AppTypography.labelSmall(onSurfaceMuted);
        }),
        height: 64,
        elevation: 0,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceVariant,
        modalBackgroundColor: surfaceVariant,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
        elevation: 0,
        modalElevation: 0,
        dragHandleColor: onSurfaceMuted.withOpacity(0.4),
        dragHandleSize: const Size(40, 4),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        titleTextStyle: AppTypography.titleLarge(onSurface),
        contentTextStyle: AppTypography.bodyMedium(onSurface),
        elevation: 0,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.darkSurfaceBright : AppColors.lightPrimary,
        contentTextStyle: AppTypography.bodyMedium(
          isDark ? AppColors.darkOnSurface : AppColors.lightOnPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceBright,
        selectedColor: primary.withOpacity(0.2),
        labelStyle: AppTypography.labelMedium(onSurface),
        side: BorderSide(color: onSurfaceMuted.withOpacity(0.2)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
      ),

      dividerTheme: DividerThemeData(
        color: onSurfaceMuted.withOpacity(0.15),
        thickness: 1,
        space: 1,
      ),

      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        titleTextStyle: AppTypography.bodyLarge(onSurface),
        subtitleTextStyle: AppTypography.bodySmall(onSurfaceMuted),
        iconColor: onSurfaceMuted,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return onSurfaceMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primary.withOpacity(0.3);
          }
          return onSurfaceMuted.withOpacity(0.2);
        }),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(onPrimary),
        side: BorderSide(color: onSurfaceMuted.withOpacity(0.5), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xs)),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return onSurfaceMuted;
        }),
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: onSurfaceMuted.withOpacity(0.2),
        thumbColor: primary,
        overlayColor: primary.withOpacity(0.12),
        valueIndicatorColor: primary,
        valueIndicatorTextStyle: AppTypography.labelSmall(onPrimary),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: onSurfaceMuted.withOpacity(0.2),
        circularTrackColor: onSurfaceMuted.withOpacity(0.2),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
        foregroundColor: isDark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
        shape: const CircleBorder(),
        elevation: 0,
        highlightElevation: 0,
      ),

      iconTheme: IconThemeData(color: onSurface, size: 24),
      primaryIconTheme: IconThemeData(color: primary, size: 24),

      tabBarTheme: TabBarThemeData(
        labelColor: primary,
        unselectedLabelColor: onSurfaceMuted,
        indicatorColor: primary,
        labelStyle: AppTypography.labelLarge(primary),
        unselectedLabelStyle: AppTypography.labelLarge(onSurfaceMuted),
        dividerColor: Colors.transparent,
      ),

      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: onSurfaceMuted,
        collapsedIconColor: onSurfaceMuted,
        textColor: primary,
        collapsedTextColor: onSurface,
        tilePadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceBright : AppColors.lightPrimary,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: AppTypography.bodySmall(
          isDark ? AppColors.darkOnSurface : AppColors.lightOnPrimary,
        ),
        waitDuration: const Duration(milliseconds: 500),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: surfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        elevation: 0,
        textStyle: AppTypography.bodyMedium(onSurface),
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(surfaceBright),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        ),
        hintStyle: WidgetStateProperty.all(AppTypography.bodyMedium(onSurfaceMuted)),
        textStyle: WidgetStateProperty.all(AppTypography.bodyMedium(onSurface)),
      ),
    );
  }
}
