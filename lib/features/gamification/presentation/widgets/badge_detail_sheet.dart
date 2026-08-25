import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';
import 'package:hybrid_tracker/features/profile/data/models/profile_model.dart';

void showBadgeDetailSheet(BuildContext context, BadgeModel badge) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => BadgeDetailSheet(badge: badge),
  );
}

class BadgeDetailSheet extends StatelessWidget {
  const BadgeDetailSheet({super.key, required this.badge});
  final BadgeModel badge;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final muted = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final gold = isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(badge.iconEmoji, style: const TextStyle(fontSize: 56))
              .animate()
              .rotate(begin: 0, end: 1, duration: 400.ms, curve: Curves.easeOut)
              .scale(begin: const Offset(0.7, 0.7), end: const Offset(1, 1)),
          const SizedBox(height: AppSpacing.md),
          Text(badge.name, style: AppTypography.titleLarge(onSurface)),
          const SizedBox(height: AppSpacing.xs),
          Text(badge.description, style: AppTypography.bodyMedium(muted), textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (i) => Icon(
                i < badge.rarity ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 18,
                color: i < badge.rarity ? gold : muted.withValues(alpha: 0.4),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            badge.isEarned && badge.earnedAt != null
                ? 'Earned ${DateFormat('MMM d, yyyy').format(badge.earnedAt!)}'
                : 'Not yet earned',
            style: AppTypography.bodySmall(muted),
          ),
        ],
      ),
    );
  }
}
