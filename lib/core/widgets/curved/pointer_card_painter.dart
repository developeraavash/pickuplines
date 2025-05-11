import 'package:flutter/material.dart';

class PointedCardPainter extends CustomPainter {
  final Color color;

  PointedCardPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // Start at top-left
    path.moveTo(0, 8);

    // Top-left rounded corner
    path.quadraticBezierTo(0, 0, 8, 0);

    // Top edge
    path.lineTo(size.width - 20, 0);

    // Pointed top-right corner
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);

    // Bottom edge
    path.lineTo(8, size.height);

    // Bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 0, size.height - 8);

    // Left edge
    path.lineTo(0, 8);

    // Fill the path
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
