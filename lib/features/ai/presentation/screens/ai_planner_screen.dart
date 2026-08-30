import 'dart:async';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: onBg, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
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

// ── AI Loading Experience ─────────────────────────────────────────────────────

class _ThinkingState extends StatefulWidget {
  const _ThinkingState({required this.gold, required this.onBg});
  final Color gold;
  final Color onBg;

  @override
  State<_ThinkingState> createState() => _ThinkingStateState();
}

class _ThinkingStateState extends State<_ThinkingState>
    with TickerProviderStateMixin {
  static const _steps = [
    (icon: Icons.task_alt_outlined, label: 'Reading your tasks'),
    (icon: Icons.loop_outlined, label: 'Checking your habits'),
    (icon: Icons.insights_outlined, label: 'Analysing your patterns'),
    (icon: Icons.calendar_month_outlined, label: 'Building your schedule'),
    (icon: Icons.auto_fix_high_outlined, label: 'Optimising time blocks'),
  ];

  static const _tips = [
    'Block your hardest task first — willpower peaks in the morning.',
    'A 5-minute break every 25 minutes keeps focus sharp all day.',
    'Habits stack better when anchored to existing routines.',
    'Writing goals down makes you 42% more likely to achieve them.',
    'Your mood log helps Ryve pick the right intensity for today.',
    'Short focus sessions beat marathon sittings for retention.',
    'Saying no to one thing = saying yes to something that matters.',
  ];

  // ~35s total: each step ~6s, tip rotates every 5s
  static const _totalMs = 38000;
  static const _stepMs = _totalMs ~/ 5;

  int _currentStep = 0;
  int _tipIndex = 0;
  double _progress = 0.0;
  late Timer _stepTimer;
  late Timer _tipTimer;
  late Timer _progressTimer;
  late AnimationController _pulseCtrl;
  late AnimationController _fadeCtrl;

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..forward();

    _stepTimer = Timer.periodic(Duration(milliseconds: _stepMs), (_) {
      if (!mounted) return;
      setState(() => _currentStep = (_currentStep + 1).clamp(0, _steps.length - 1));
    });

    _tipTimer = Timer.periodic(const Duration(milliseconds: 5200), (_) {
      if (!mounted) return;
      _fadeCtrl.reverse().then((_) {
        if (!mounted) return;
        setState(() => _tipIndex = (_tipIndex + 1) % _tips.length);
        _fadeCtrl.forward();
      });
    });

    _progressTimer = Timer.periodic(const Duration(milliseconds: 120), (_) {
      if (!mounted) return;
      setState(() {
        _progress = (_progress + 120 / _totalMs).clamp(0.0, 0.97);
      });
    });
  }

  @override
  void dispose() {
    _stepTimer.cancel();
    _tipTimer.cancel();
    _progressTimer.cancel();
    _pulseCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final gold = widget.gold;
    final onBg = widget.onBg;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl, vertical: AppSpacing.xxl),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // Pulsing logo
          AnimatedBuilder(
            animation: _pulseCtrl,
            builder: (_, child) => Transform.scale(
              scale: 1.0 + _pulseCtrl.value * 0.12,
              child: Opacity(
                opacity: 0.8 + _pulseCtrl.value * 0.2,
                child: child,
              ),
            ),
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gold.withValues(alpha: 0.1),
                border: Border.all(color: gold.withValues(alpha: 0.3), width: 1.5),
              ),
              child: Center(
                child: SvgPicture.asset('assets/logo/ryve_mark.svg', width: 52, height: 52),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          Text(
            'Building your perfect day…',
            style: AppTypography.titleMedium(onBg),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'AI is analysing your data — takes ~35s',
            style: AppTypography.bodySmall(muted),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.xl),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 6,
              backgroundColor: gold.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(gold),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(_progress * 100).toInt()}%',
              style: AppTypography.labelSmall(muted),
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Step pipeline
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              children: List.generate(_steps.length, (i) {
                final done = i < _currentStep;
                final active = i == _currentStep;
                final color = done
                    ? AppColors.success
                    : active
                        ? gold
                        : muted.withValues(alpha: 0.4);

                return Padding(
                  padding: EdgeInsets.only(bottom: i < _steps.length - 1 ? AppSpacing.md : 0),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withValues(alpha: 0.15),
                          border: Border.all(color: color, width: 1.5),
                        ),
                        child: Icon(
                          done ? Icons.check_rounded : _steps[i].icon,
                          size: 16,
                          color: color,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: (active
                                  ? AppTypography.bodyMedium(onBg)
                                  : AppTypography.bodySmall(color))
                              .copyWith(fontWeight: active ? FontWeight.w600 : FontWeight.normal),
                          child: Text(_steps[i].label),
                        ),
                      ),
                      if (active)
                        SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(gold),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: AppSpacing.xl),

          // Rotating productivity tip
          FadeTransition(
            opacity: _fadeCtrl,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: gold.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: gold.withValues(alpha: 0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline_rounded, color: gold, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      _tips[_tipIndex],
                      style: AppTypography.bodySmall(onBg),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Tip counter dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_tips.length, (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == _tipIndex ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == _tipIndex ? gold : muted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            )),
          ),

          const SizedBox(height: AppSpacing.xxl),
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
        if (notifier.tasksUpdatedAfterPlan)
          GestureDetector(
            onTap: notifier.regenerate,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: gold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: gold.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.update_rounded, color: gold, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Tasks updated since last plan — tap to refresh',
                      style: AppTypography.bodySmall(onBg),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: gold, size: 18),
                ],
              ),
            ),
          ),
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
