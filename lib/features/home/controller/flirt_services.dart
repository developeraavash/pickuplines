import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class FlirtServices {
  // Load flirt lines by category
  Future<List<dynamic>> loadFlirtLines(String category) async {
    final String response = await rootBundle.loadString(
      'assets/data/flirt_data.json',
    );
    final data = await json.decode(response);
    return data['flirt_content'][category];
  }

  // Get random line from any category
  Future<Map<String, dynamic>> getRandomFlirtLine() async {
    final response = await rootBundle.loadString(
      'assets/data/quotes_content.json',
    );
    final data = json.decode(response);
    final categories = data['flirt_content'].keys.toList();
    final randomCategory = categories[Random().nextInt(categories.length)];
    final lines = data['flirt_content'][randomCategory];
    return lines[Random().nextInt(lines.length)];
  }
}
