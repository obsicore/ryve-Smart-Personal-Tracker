import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/core/theme/theme_provider.dart';
import 'package:hybrid_tracker/features/customization/domain/providers/customization_providers.dart';

class AppearanceScreen extends ConsumerWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final themesAsync = ref.watch(appThemesProvider);
    final activeIdAsync = ref.watch(activeThemeIdProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Appearance', style: AppTypography.titleLarge(onBg)),
      ),
      body: themesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text('Could not load themes', style: AppTypography.bodyMedium(muted))),
        data: (themes) {
          final activeId = activeIdAsync.valueOrNull ?? (isDark ? 'forest-dark' : 'desert-light');
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text('Display Mode', style: AppTypography.titleMedium(onBg)),
              const SizedBox(height: AppSpacing.sm),
              SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(value: ThemeMode.system, label: Text('System')),
                  ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                  ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                ],
                selected: {themeMode},
                onSelectionChanged: (s) => ref.read(themeModeProvider.notifier).setMode(s.first),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Accent Theme', style: AppTypography.titleMedium(onBg)),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Sets your accent color preference. Full re-skin support is planned; '
                'today the Forest palette remains the base look.',
                style: AppTypography.bodySmall(muted),
              ),
              const SizedBox(height: AppSpacing.sm),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.4,
                children: themes.asMap().entries.map((entry) {
                  final i = entry.key;
                  final t = entry.value;
                  final selected = t.id == activeId;
                  return _ThemeCard(theme: t, selected: selected, surface: surface, onBg: onBg, gold: gold)
                      .animate(delay: (i * 50).ms)
                      .fadeIn(duration: 200.ms)
                      .scale(begin: const Offset(0.95, 0.95));
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ThemeCard extends ConsumerWidget {
  const _ThemeCard({required this.theme, required this.selected, required this.surface, required this.onBg, required this.gold});
  final AppThemeRecord theme;
  final bool selected;
  final Color surface, onBg, gold;

  Color _hex(String hex) => Color(int.parse(hex.replaceFirst('#', 'FF'), radix: 16));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.md),
      onTap: () => ref.read(customizationActionsProvider.notifier).selectTheme(theme.id),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppSpacing.md),
          border: Border.all(color: selected ? gold : Colors.transparent, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _swatch(_hex(theme.backgroundHex)),
                _swatch(_hex(theme.primaryHex)),
                _swatch(_hex(theme.accentHex)),
              ],
            ),
            const Spacer(),
            Text(
              theme.name,
              style: AppTypography.bodyMedium(onBg),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (selected) Icon(Icons.check_circle, color: gold, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _swatch(Color c) => Container(
        margin: const EdgeInsets.only(right: 4),
        width: 18,
        height: 18,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );
}
