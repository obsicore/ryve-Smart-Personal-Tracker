import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';
import 'package:hybrid_tracker/features/sleep/domain/providers/sleep_providers.dart';
import 'package:hybrid_tracker/features/sleep/presentation/screens/alarm_screen.dart';

class AlarmCardWidget extends ConsumerWidget {
  const AlarmCardWidget({super.key, required this.alarm});

  final AlarmModel alarm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceBright =
        isDark ? AppColors.darkSurfaceBright : AppColors.lightSurfaceBright;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final secondary =
        isDark ? AppColors.darkSecondary : AppColors.lightSecondary;

    return Dismissible(
      key: ValueKey(alarm.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.error),
      ),
      onDismissed: (_) {
        ref.read(alarmNotifierProvider.notifier).delete(alarm.id);
      },
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) => AlarmScreen(existing: alarm),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border:
                isDark ? Border.all(color: surfaceBright, width: 1) : null,
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alarm.timeFormatted,
                      style: AppTypography.headlineLarge(onSurface),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Text(
                          alarm.daysLabel,
                          style: AppTypography.bodySmall(muted),
                        ),
                        if (alarm.label.isNotEmpty &&
                            alarm.label != 'Wake Up') ...[
                          Text(
                            '  ·  ',
                            style: AppTypography.bodySmall(muted),
                          ),
                          Flexible(
                            child: Text(
                              alarm.label,
                              style: AppTypography.bodySmall(muted),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Switch(
                value: alarm.isEnabled,
                activeTrackColor: secondary,
                activeThumbColor: Colors.white,
                inactiveThumbColor: muted,
                inactiveTrackColor: surfaceBright,
                onChanged: (v) {
                  ref
                      .read(alarmNotifierProvider.notifier)
                      .toggle(alarm.id, v);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
