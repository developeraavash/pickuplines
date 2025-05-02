import 'package:pickuplines/core/utils/helpers/THelperFunc.dart';
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final BuildContext context;

  BackgroundPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final isDarkMode = Thelperfunc.isDarkMode(context);

    // Define gradient colors for dark and light mode
    final gradientColors =
        isDarkMode
            ? [Colors.black, Colors.grey[900]!, Colors.grey[850]!]
            : [Colors.grey[200]!, Colors.grey[300]!, Colors.grey[700]!];

    // Draw the gradient background
    final gradientPaint =
        Paint()
          ..shader = LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      gradientPaint,
    );

    // Draw semi-transparent circles
    final circlePaint =
        Paint()
          ..color =
              isDarkMode
                  ? Colors.grey.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.1)
          ..style = PaintingStyle.fill;

    final smallerCircles = [
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.7, size.height * 0.6),
      Offset(size.width * 0.2, size.height * 0.9),
    ];

    for (final circle in smallerCircles) {
      canvas.drawCircle(circle, 30, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
