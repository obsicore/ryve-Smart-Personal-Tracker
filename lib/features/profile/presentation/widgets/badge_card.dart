import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/profile/data/models/profile_model.dart';

class BadgeCard extends StatefulWidget {
  const BadgeCard({
    super.key,
    required this.badge,
    this.animationDelay = Duration.zero,
  });

  final BadgeModel badge;
  final Duration animationDelay;

  @override
  State<BadgeCard> createState() => _BadgeCardState();
}

class _BadgeCardState extends State<BadgeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _pressAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 120),
    );
    _pressAnimation = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _pressController.forward();
  void _onTapUp(TapUpDetails _) => _pressController.reverse();
  void _onTapCancel() => _pressController.reverse();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceVariant =
        isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
    final textColor =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor =
        isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;
    final goldColor =
        isDark ? AppColors.darkPrimary : AppColors.lightAccent;

    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: widget.badge.isEarned ? surfaceVariant : surfaceColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: widget.badge.isEarned
            ? Border.all(
                color: goldColor.withValues(alpha: 0.3),
                width: 1,
              )
            : Border.all(
                color: mutedColor.withValues(alpha: 0.15),
                width: 1,
              ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Emoji + lock overlay
          SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  widget.badge.iconEmoji,
                  style: const TextStyle(fontSize: 36),
                ),
                if (!widget.badge.isEarned)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '🔒',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.badge.name,
            style: TextStyle(
              color: widget.badge.isEarned ? textColor : mutedColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          _RarityStars(
            rarity: widget.badge.rarity,
            isEarned: widget.badge.isEarned,
            goldColor: goldColor,
            mutedColor: mutedColor,
          ),
        ],
      ),
    );

    if (!widget.badge.isEarned) {
      cardContent = ColorFiltered(
        colorFilter: ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0,      0,      0,      0.6, 0,
        ]),
        child: cardContent,
      );
    }

    Widget result = GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _pressAnimation,
        builder: (context, child) => Transform.scale(
          scale: _pressAnimation.value,
          child: child,
        ),
        child: cardContent,
      ),
    );

    if (!disableAnimations) {
      result = result
          .animate(delay: widget.animationDelay)
          .scale(
            begin: const Offset(0, 0),
            end: const Offset(1, 1),
            duration: 400.ms,
            curve: Curves.elasticOut,
          )
          .fadeIn(duration: 200.ms);
    }

    return result;
  }
}

class _RarityStars extends StatelessWidget {
  const _RarityStars({
    required this.rarity,
    required this.isEarned,
    required this.goldColor,
    required this.mutedColor,
  });

  final int rarity;
  final bool isEarned;
  final Color goldColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (i) => Icon(
          i < rarity ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 10,
          color: i < rarity
              ? (isEarned ? goldColor : mutedColor)
              : mutedColor.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
