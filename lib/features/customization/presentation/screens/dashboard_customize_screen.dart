import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/customization/domain/providers/customization_providers.dart';

class DashboardCustomizeScreen extends ConsumerWidget {
  const DashboardCustomizeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    final cardsAsync = ref.watch(dashboardCardsConfigProvider);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: onBg, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Customize Dashboard', style: AppTypography.titleLarge(onBg)),
      ),
      body: cardsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text('Could not load dashboard layout', style: AppTypography.bodyMedium(muted))),
        data: (cards) {
          if (cards.isEmpty) {
            return Center(child: Text('No dashboard layout configured yet', style: AppTypography.bodyMedium(muted)));
          }
          return ReorderableListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: cards.length,
            onReorder: (oldIndex, newIndex) {
              final reordered = [...cards];
              if (newIndex > oldIndex) newIndex -= 1;
              final item = reordered.removeAt(oldIndex);
              reordered.insert(newIndex, item);
              ref.read(customizationActionsProvider.notifier).reorder(reordered);
            },
            itemBuilder: (context, i) {
              final c = cards[i];
              return Container(
                key: ValueKey(c.id),
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(AppSpacing.md)),
                child: Row(
                  children: [
                    Icon(Icons.drag_handle, color: muted),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: Text(_cardLabel(c.cardType), style: AppTypography.bodyMedium(onBg))),
                    Switch(
                      value: c.isVisible,
                      activeThumbColor: gold,
                      onChanged: (v) => ref.read(customizationActionsProvider.notifier).toggleCard(c.id, v),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _cardLabel(String type) {
    switch (type) {
      case 'streak':
        return 'Streak Card';
      case 'habits':
        return "Today's Habits";
      case 'tasks':
        return "Today's Tasks";
      case 'mood_water':
        return 'Mood & Water';
      case 'ai_insight':
        return 'AI Insight';
      default:
        return type;
    }
  }
}
