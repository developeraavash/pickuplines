import 'package:flutter/material.dart';
import 'package:pickuplines/core/widgets/curved/pointer_card_painter.dart';

class PointedQuoteCard extends StatelessWidget {
  final String title;
  final String author;
  final Color color;
  final VoidCallback? onTap;

  const PointedQuoteCard({
    super.key,
    required this.title,
    required this.author,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: PointedCardPainter(color: color),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    author,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const Icon(Icons.more_horiz, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
