import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class XpFloatOverlay extends StatelessWidget {
  const XpFloatOverlay({super.key, required this.xp});

  final int xp;

  static void show(
    BuildContext context,
    int xp, {
    Offset? position,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    final renderBox = context.findRenderObject() as RenderBox?;
    final anchorOffset = renderBox != null
        ? renderBox.localToGlobal(
            Offset(renderBox.size.width / 2, renderBox.size.height / 2),
          )
        : position ?? const Offset(0, 0);

    final resolvedPosition = position ?? anchorOffset;

    entry = OverlayEntry(
      builder: (_) => Positioned(
        left: resolvedPosition.dx - 30,
        top: resolvedPosition.dy - 20,
        child: IgnorePointer(
          child: XpFloatOverlay(xp: xp),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(milliseconds: 850), entry.remove);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        '+$xp XP',
        style: const TextStyle(
          color: Color(0xFFC9A84C),
          fontSize: 20,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.none,
        ),
      )
          .animate()
          .fadeIn(duration: 150.ms)
          .moveY(
            begin: 0,
            end: -52,
            duration: 650.ms,
            curve: Curves.easeOut,
          )
          .fadeOut(
            delay: 400.ms,
            duration: 250.ms,
          ),
    );
  }
}
