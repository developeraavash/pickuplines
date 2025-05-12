import 'dart:ui' show Offset, Path, Size;

import 'package:flutter/material.dart';

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top-left corner
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 60);

    // Left half heart curve bottom point
    var leftCP1 = Offset(size.width * 0.10, size.height + 20);
    var leftCP2 = Offset(size.width * 0.20, size.height - 40);
    var leftEndPoint = Offset(size.width * 0.25, size.height - 20);
    path.cubicTo(
      leftCP1.dx,
      leftCP1.dy,
      leftCP2.dx,
      leftCP2.dy,
      leftEndPoint.dx,
      leftEndPoint.dy,
    );

    // Left heart top lobe (peak between hearts)
    var leftCP3 = Offset(size.width * 0.35, size.height);
    var leftCP4 = Offset(size.width * 0.40, size.height - 60);
    var middlePoint = Offset(size.width * 0.50, size.height - 30);
    path.cubicTo(
      leftCP3.dx,
      leftCP3.dy,
      leftCP4.dx,
      leftCP4.dy,
      middlePoint.dx,
      middlePoint.dy,
    );

    // Right heart top lobe (peak between hearts)
    var rightCP1 = Offset(size.width * 0.60, size.height - 60);
    var rightCP2 = Offset(size.width * 0.65, size.height);
    var rightEndPoint = Offset(size.width * 0.75, size.height - 20);
    path.cubicTo(
      rightCP1.dx,
      rightCP1.dy,
      rightCP2.dx,
      rightCP2.dy,
      rightEndPoint.dx,
      rightEndPoint.dy,
    );

    // Right half heart curve bottom point
    var rightCP3 = Offset(size.width * 0.80, size.height - 40);
    var rightCP4 = Offset(size.width * 0.90, size.height + 20);
    var rightTop = Offset(size.width, size.height - 60);
    path.cubicTo(
      rightCP3.dx,
      rightCP3.dy,
      rightCP4.dx,
      rightCP4.dy,
      rightTop.dx,
      rightTop.dy,
    );

    // Line to top-right corner
    path.lineTo(size.width, 0);

    // Close path back to the start
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
