import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/curved/pointer_card_painter.dart';

class PointedFlirtDetailCard extends StatelessWidget {
  final String title;
  final String author;
  final Color color;
  final String quote;

  const PointedFlirtDetailCard({
    super.key,
    required this.title,
    required this.author,
    required this.color,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PointedCardPainter(color: color),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.md,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        author,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: AppSizes.md,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz, color: Colors.white),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              '"$quote"',
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppSizes.md,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
