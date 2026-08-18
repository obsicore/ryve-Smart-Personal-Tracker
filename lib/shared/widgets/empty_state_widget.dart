import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.svgAssetPath,
    required this.title,
    required this.subtitle,
    this.ctaLabel,
    this.onCta,
  });

  final String svgAssetPath;
  final String title;
  final String subtitle;
  final String? ctaLabel;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    Widget illustration = SvgPicture.asset(
      svgAssetPath,
      width: 180,
      height: 144,
    );

    Widget titleWidget = Text(
      title,
      textAlign: TextAlign.center,
      style: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
    );

    Widget subtitleWidget = Text(
      subtitle,
      textAlign: TextAlign.center,
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface.withOpacity(0.6),
        height: 1.5,
      ),
    );

    if (!disableAnimations) {
      illustration = illustration
          .animate()
          .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            duration: 350.ms,
            curve: Curves.elasticOut,
          );

      titleWidget = titleWidget
          .animate()
          .fadeIn(duration: 280.ms, delay: 100.ms)
          .moveY(begin: 12, end: 0, duration: 280.ms, delay: 100.ms);

      subtitleWidget = subtitleWidget
          .animate()
          .fadeIn(duration: 250.ms, delay: 200.ms);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          illustration,
          const SizedBox(height: 24),
          titleWidget,
          const SizedBox(height: 8),
          subtitleWidget,
          if (ctaLabel != null && onCta != null) ...[
            const SizedBox(height: 32),
            _buildCta(disableAnimations),
          ],
        ],
      ),
    );
  }

  Widget _buildCta(bool disableAnimations) {
    final button = RyveButton(
      label: ctaLabel!,
      onPressed: onCta,
    );

    if (disableAnimations) return button;

    return button
        .animate()
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 400.ms,
          delay: 350.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 200.ms, delay: 350.ms);
  }
}
