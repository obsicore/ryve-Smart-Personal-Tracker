import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:hybrid_tracker/core/router/app_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/ai/data/models/ai_plan_item_model.dart';
import 'package:hybrid_tracker/features/ai/data/models/ai_plan_model.dart';
import 'package:hybrid_tracker/features/ai/domain/providers/ai_providers.dart';

class AIPlannerScreen extends ConsumerWidget {
  const AIPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    final planState = ref.watch(aIPlannerNotifierProvider);
    final notifier = ref.read(aIPlannerNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: Text('AI Day Planner', style: AppTypography.titleLarge(onBg)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active_outlined, color: onBg),
            tooltip: 'Smart Reminders',
            onPressed: () => context.push(Routes.smartReminders),
          ),
        ],
      ),
      body: planState.when(
        loading: () => _ThinkingState(gold: gold, onBg: onBg),
        error: (_, __) => Center(
          child: Text('Could not build a plan right now.', style: AppTypography.bodyMedium(muted)),
        ),
        data: (plan) {
          if (plan == null || plan.items.isEmpty) {
            return _EmptyPlanState(
              onBg: onBg,
              muted: muted,
              gold: gold,
              onGenerate: notifier.generate,
            );
          }
          return _PlanBody(plan: plan, notifier: notifier);
        },
      ),
    );
  }
}

class _ThinkingState extends StatefulWidget {
  const _ThinkingState({required this.gold, required this.onBg});
  final Color gold;
  final Color onBg;

  @override
  State<_ThinkingState> createState() => _ThinkingStateState();
}

class _ThinkingStateState extends State<_ThinkingState> {
  int _dots = 0;
  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return false;
      setState(() => _dots = (_dots + 1) % 4);
      return mounted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/logo/ryve_mark.svg',
            width: 64,
            height: 64,
          ).animate(onPlay: (c) => c.repeat()).rotate(duration: 1400.ms),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Ryve is thinking${'.' * _dots}',
            style: AppTypography.bodyMedium(widget.onBg),
          ),
        ],
      ),
    );
  }
}

class _EmptyPlanState extends StatelessWidget {
  const _EmptyPlanState({
    required this.onBg,
    required this.muted,
    required this.gold,
    required this.onGenerate,
  });
  final Color onBg;
  final Color muted;
  final Color gold;
  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/illustrations/ai_plan_empty.svg', width: 160, height: 128),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Let AI plan your day',
              style: AppTypography.titleMedium(onBg),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              "We'll build a schedule from your tasks, habits, and recent trends.",
              style: AppTypography.bodySmall(muted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton(
              onPressed: onGenerate,
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                foregroundColor: AppColors.darkOnPrimary,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl, vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.xl)),
              ),
              child: const Text('Generate Plan'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanBody extends ConsumerWidget {
  const _PlanBody({required this.plan, required this.notifier});
  final AIPlanModel plan;
  final AIPlannerNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;
    final usedAI = notifier.lastGenerationUsedAI;
    final pending = plan.items.where((i) => i.itemStatus == 'pending').isNotEmpty;

    return Column(
      children: [
        if (!usedAI)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(AppSpacing.lg),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.wifi_off_rounded, color: AppColors.warning, size: 18),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'AI unavailable — showing smart suggestions',
                    style: AppTypography.bodySmall(onBg),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            itemCount: plan.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) => _PlanItemCard(
              item: plan.items[i],
              onAccept: () => notifier.acceptItem(plan.items[i].id),
              onReject: () => notifier.rejectItem(plan.items[i].id),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: notifier.regenerate,
                  child: const Text('Regenerate'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: pending ? notifier.acceptAll : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: AppColors.darkOnPrimary,
                  ),
                  child: const Text('Accept All'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlanItemCard extends StatelessWidget {
  const _PlanItemCard({required this.item, required this.onAccept, required this.onReject});
  final AIPlanItemModel item;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  Color _typeColor(bool isDark) => switch (item.itemType) {
        AIPlanItemType.task => isDark ? AppColors.darkPrimary : AppColors.lightAccent,
        AIPlanItemType.habit => isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
        AIPlanItemType.focus => AppColors.info,
        AIPlanItemType.breakTime => AppColors.priorityLow,
      };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final typeColor = _typeColor(isDark);
    final decided = item.itemStatus != 'pending';

    Widget card = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: decided
              ? (item.itemStatus == 'accepted' ? AppColors.success : AppColors.error)
                  .withValues(alpha: 0.4)
              : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(item.slotStart, style: AppTypography.labelSmall(typeColor)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTypography.bodyMedium(onSurface),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(item.itemType.label, style: AppTypography.bodySmall(muted)),
              ],
            ),
          ),
          if (!decided) ...[
            IconButton(
              icon: const Icon(Icons.close_rounded, color: AppColors.error),
              onPressed: onReject,
            ),
            IconButton(
              icon: const Icon(Icons.check_rounded, color: AppColors.success),
              onPressed: onAccept,
            ),
          ] else
            Icon(
              item.itemStatus == 'accepted' ? Icons.check_circle : Icons.cancel,
              color: item.itemStatus == 'accepted' ? AppColors.success : AppColors.error,
              size: 18,
            ),
        ],
      ),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: card,
    );
  }
}
