import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:hybrid_tracker/core/theme/app_colors.dart';

class XpFloatOverlay {
  static void show(BuildContext context, int amount, {Offset? position}) {
    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    final origin = position ??
        (renderBox != null
            ? renderBox.localToGlobal(renderBox.size.center(Offset.zero))
            : MediaQuery.of(context).size.center(Offset.zero));

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => Positioned(
        left: origin.dx - 30,
        top: origin.dy - 20,
        child: IgnorePointer(
          child: Text(
            '+$amount XP',
            style: TextStyle(
              color: AppColors.darkPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          )
              .animate()
              .fadeIn(duration: 150.ms)
              .moveY(begin: 0, end: -52, duration: 650.ms, curve: Curves.easeOut)
              .fadeOut(delay: 400.ms, duration: 250.ms),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (entry.mounted) entry.remove();
    });
  }
}
