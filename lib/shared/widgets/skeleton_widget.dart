import 'package:flutter/material.dart';

class SkeletonWidget extends StatefulWidget {
  const SkeletonWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<SkeletonWidget> createState() => _SkeletonWidgetState();
}

class _SkeletonWidgetState extends State<SkeletonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    if (disableAnimations) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surfaceBright;

    if (disableAnimations) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: ColoredBox(color: baseColor),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [
                (_shimmerAnimation.value - 0.3).clamp(0.0, 1.0),
                _shimmerAnimation.value.clamp(0.0, 1.0),
                (_shimmerAnimation.value + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: child,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: ColoredBox(color: baseColor),
        ),
      ),
    );
  }
}
