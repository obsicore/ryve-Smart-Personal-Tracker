import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_animations.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/core/utils/wellness_constants.dart';
import 'package:hybrid_tracker/features/wellness/data/models/water_log_model.dart';
import 'package:hybrid_tracker/features/wellness/domain/providers/wellness_providers.dart';

class WaterTrackerWidget extends ConsumerWidget {
  const WaterTrackerWidget({super.key, this.goalMl = defaultWaterGoalMl});

  final int goalMl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onBg = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final secondary = isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    final logsAsync = ref.watch(todayWaterLogsProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: isDark ? Border.all(color: AppColors.darkSurfaceBright) : null,
      ),
      child: logsAsync.when(
        loading: () => const SizedBox(height: 160, child: Center(child: CircularProgressIndicator())),
        error: (_, __) => const SizedBox.shrink(),
        data: (logs) {
          final totalMl = logs.fold<int>(0, (sum, l) => sum + l.amountMl);
          final progress = (totalMl / goalMl).clamp(0.0, 1.0);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Water', style: AppTypography.titleMedium(onBg)),
              const SizedBox(height: AppSpacing.md),
              Center(
                child: Column(
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: progress),
                      duration: disableAnims ? Duration.zero : AppAnimations.slow,
                      curve: AppAnimations.smooth,
                      builder: (context, value, _) => CustomPaint(
                        size: const Size(120, 120),
                        painter: _WaterArcPainter(progress: value, color: secondary, track: isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceVariant),
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${totalMl}ml', style: AppTypography.titleMedium(onSurface)),
                                Text('of ${goalMl}ml', style: AppTypography.bodySmall(muted)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  _QuickAddChip(label: '+150ml', color: secondary, onTap: () => ref.read(wellnessNotifierProvider.notifier).logWater(150)),
                  const SizedBox(width: AppSpacing.sm),
                  _QuickAddChip(label: '+250ml', color: secondary, onTap: () => ref.read(wellnessNotifierProvider.notifier).logWater(250)),
                  const SizedBox(width: AppSpacing.sm),
                  _QuickAddChip(label: '+350ml', color: secondary, onTap: () => ref.read(wellnessNotifierProvider.notifier).logWater(350)),
                  const SizedBox(width: AppSpacing.sm),
                  _QuickAddChip(
                    label: 'Custom',
                    color: muted,
                    onTap: () => _showCustomDialog(context, ref),
                  ),
                ],
              ),
              if (logs.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: logs.map((l) => _LogChip(log: l, color: secondary, muted: muted)).toList(),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _showCustomDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add water'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(suffixText: 'ml'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(int.tryParse(controller.text)),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (result != null && result > 0) {
      await ref.read(wellnessNotifierProvider.notifier).logWater(result);
    }
  }
}

class _QuickAddChip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAddChip({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          alignment: Alignment.center,
          child: Text(label, style: AppTypography.labelSmall(color)),
        ),
      ),
    );
  }
}

class _LogChip extends StatelessWidget {
  final WaterLogModel log;
  final Color color;
  final Color muted;

  const _LogChip({required this.log, required this.color, required this.muted});

  @override
  Widget build(BuildContext context) {
    final h = log.logTime.hour;
    final m = log.logTime.minute;
    final period = h >= 12 ? 'PM' : 'AM';
    final displayH = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        '$displayH:${m.toString().padLeft(2, '0')} $period · ${log.amountMl}ml',
        style: AppTypography.labelSmall(muted),
      ),
    );
  }
}

class _WaterArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color track;

  const _WaterArcPainter({required this.progress, required this.color, required this.track});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(6, 6, size.width - 12, size.height - 12);
    const startAngle = -math.pi / 2;
    const sweepFull = math.pi * 2;

    final trackPaint = Paint()
      ..color = track
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepFull, false, trackPaint);
    canvas.drawArc(rect, startAngle, sweepFull * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(_WaterArcPainter old) => old.progress != progress;
}
