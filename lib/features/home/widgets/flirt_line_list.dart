import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/features/home/widgets/top_flirt_line.dart';

class FlirtLinesList extends StatelessWidget {
  final List<Map<String, dynamic>> flirtLines;

  const FlirtLinesList({super.key, required this.flirtLines});

  @override
  Widget build(BuildContext context) {
    // Group lines by category
    final Map<String, List<Map<String, dynamic>>> linesByCategory = {};
    for (var line in flirtLines) {
      final category = line['category'];
      if (!linesByCategory.containsKey(category)) {
        linesByCategory[category] = [];
      }
      linesByCategory[category]!.add(line);
    }

    // Get one random line from each category
    final Random random = Random();
    final List<Map<String, dynamic>> representativeLines = [];

    linesByCategory.forEach((category, lines) {
      if (lines.isNotEmpty) {
        final randomLine = lines[random.nextInt(lines.length)];
        representativeLines.add(randomLine);
      }
    });

    // Shuffle the lines so they appear in random order
    representativeLines.shuffle();

    return SizedBox(
      height: AppSizes.scrollableCardSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var i = 0; i < representativeLines.length; i++)
            Padding(
              padding: EdgeInsets.only(
                right: i < representativeLines.length - 1 ? 16 : 0,
              ),
              child: TopFlirtLines(
                category: representativeLines[i]['category'],
                line: representativeLines[i]['line'],
                color: _getColorForCategory(representativeLines[i]['category']),
              ),
            ),
        ],
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'playful':
        return const Color(0xFF9E8FFF);
      case 'romantic':
        return const Color(0xFFFF6B9E);
      case 'cheeky':
        return const Color(0xFFF9BA51);
      case 'intellectual':
        return const Color(0xFF5EAFC0);
      case 'situational':
        return const Color(0xFF5ED584);
      default:
        return const Color(0xFFB57470);
    }
  }
}
