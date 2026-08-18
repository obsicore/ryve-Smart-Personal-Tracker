import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/core/theme/app_typography.dart';

class AiSuggestionBannerWidget extends StatelessWidget {
  final String text;

  const AiSuggestionBannerWidget({
    super.key,
    this.text =
        'Plan your hardest task first thing in the morning for peak focus.',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final gold = AppColors.darkPrimary;
    final disableAnims = MediaQuery.of(context).disableAnimations;

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isDark ? AppColors.darkSurfaceBright : Colors.transparent,
          width: 1,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gold left border accent
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(AppRadius.md),
              ),
              child: disableAnims
                  ? Container(
                      width: 4,
                      color: gold,
                    )
                  : Container(width: 4, color: gold)
                      .animate(
                        onPlay: (ctrl) => ctrl.repeat(reverse: true),
                      )
                      .fadeIn(
                        begin: 0.6,
                        duration: const Duration(milliseconds: 1000),
                      )
                      .then()
                      .fadeOut(
                        duration: const Duration(milliseconds: 1000),
                      ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, color: gold, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Suggestion',
                            style: AppTypography.labelMedium(gold),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            text,
                            style: AppTypography.bodySmall(onSurface),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
