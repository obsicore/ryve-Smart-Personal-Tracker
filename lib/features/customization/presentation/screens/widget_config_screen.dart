import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/customization/domain/providers/customization_providers.dart';

const _widgetMeta = {
  'habit_progress': (label: 'Habit Progress', desc: 'Circular arc showing today\'s habits done', icon: Icons.donut_large),
  'focus_quick_start': (label: 'Pomodoro Quick Start', desc: 'Tap to jump into a focus session', icon: Icons.play_circle_outline),
  'water_tracker': (label: 'Water Tracker', desc: 'Today\'s water intake vs. goal', icon: Icons.water_drop_outlined),
};

class WidgetConfigScreen extends ConsumerWidget {
  const WidgetConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final configsAsync = ref.watch(widgetConfigsProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('Home Screen Widgets', style: AppTypography.titleLarge(onBg)),
      ),
      body: configsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text('Could not load widgets', style: AppTypography.bodyMedium(muted))),
        data: (configs) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                'Enable a widget, then add it to your home screen the usual way '
                '(long-press home screen → Widgets → Ryve). Position below is a preference only.',
                style: AppTypography.bodySmall(muted),
              ),
              const SizedBox(height: AppSpacing.md),
              ...configs.asMap().entries.map((entry) {
                final i = entry.key;
                final c = entry.value;
                final meta = _widgetMeta[c.widgetType];
                if (meta == null) return const SizedBox.shrink();
                return Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppSpacing.md)),
                  child: Row(
                    children: [
                      Icon(meta.icon, color: gold),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(meta.label, style: AppTypography.bodyMedium(onBg)),
                            Text(meta.desc, style: AppTypography.bodySmall(muted)),
                          ],
                        ),
                      ),
                      Switch(
                        value: c.isEnabled,
                        activeThumbColor: gold,
                        onChanged: (v) => ref.read(customizationActionsProvider.notifier).toggleWidget(c.id, v),
                      ),
                    ],
                  ),
                ).animate(delay: (i * 60).ms).fadeIn(duration: 200.ms).slideY(begin: 0.1, end: 0);
              }),
            ],
          );
        },
      ),
    );
  }
}
