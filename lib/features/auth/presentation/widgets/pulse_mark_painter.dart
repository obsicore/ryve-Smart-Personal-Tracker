import 'package:flutter/material.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';

/// CustomPainter that draws the Ryve heartbeat/pulse logo mark.
///
/// [progress] controls how much of the path is drawn (0.0 → 1.0).
/// [dotScale] controls the size of the green endpoint dot (0.0 → 1.0).
class PulseMarkPainter extends CustomPainter {
  const PulseMarkPainter({
    required this.progress,
    required this.dotScale,
  });

  final double progress;
  final double dotScale;

  static const _viewBox = Size(56, 56);

  static Path _buildRawPath() {
    final path = Path();
    path.moveTo(6, 32);
    path.cubicTo(10, 32, 13, 18, 17, 18);
    path.cubicTo(21, 18, 22, 38, 26, 38);
    path.cubicTo(30, 38, 32, 10, 36, 10);
    path.cubicTo(40, 10, 41, 38, 45, 38);
    path.cubicTo(47, 38, 49, 28, 51, 28);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / _viewBox.width;
    final scaleY = size.height / _viewBox.height;
    final scale = scaleX < scaleY ? scaleX : scaleY;
    final dx = (size.width - _viewBox.width * scale) / 2;
    final dy = (size.height - _viewBox.height * scale) / 2;

    canvas.save();
    canvas.translate(dx, dy);
    canvas.scale(scale);

    if (progress > 0) {
      final rawPath = _buildRawPath();
      final metrics = rawPath.computeMetrics().toList();
      final totalLength = metrics.fold<double>(0, (sum, m) => sum + m.length);
      final targetLength = totalLength * progress;

      double drawn = 0;
      final paint = Paint()
        ..color = AppColors.darkPrimary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      for (final metric in metrics) {
        final remaining = targetLength - drawn;
        if (remaining <= 0) break;
        final extract = remaining >= metric.length ? metric.length : remaining;
        canvas.drawPath(metric.extractPath(0, extract), paint);
        drawn += metric.length;
      }
    }

    if (dotScale > 0) {
      final dotPaint = Paint()..color = AppColors.darkSecondary;
      canvas.drawCircle(const Offset(51, 28), 3.0 * dotScale, dotPaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(PulseMarkPainter old) =>
      old.progress != progress || old.dotScale != dotScale;
}
