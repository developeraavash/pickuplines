import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlirtServices with ChangeNotifier {
  List<dynamic> _flirtLines = [];
  List<dynamic> _topCategoryLines = [];
  bool _isLoading = true;
  final Random _random = Random();

  List<dynamic> get flirtLines => _flirtLines;
  List<dynamic> get topCategoryLines => _topCategoryLines;
  bool get isLoading => _isLoading;

  Future<void> loadFlirtContent() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/home/flirt_data.json',
      );
      final data = await json.decode(response);
      final List<String> categories = [
        'playful',
        'romantic',
        'cheeky',
        'intellectual',
        'situational',
      ];

      _flirtLines = [];
      for (final category in categories) {
        if (data['flirt_content'][category] != null) {
          _flirtLines.addAll(data['flirt_content'][category]);
        }
      }

      // Get one random line from each category for the top section
      _topCategoryLines = _getTopCategoryLines(data['flirt_content']);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading flirt content: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  List<dynamic> _getTopCategoryLines(Map<String, dynamic> flirtContent) {
    List<dynamic> result = [];
    final categories = [
      'playful',
      'romantic',
      'cheeky',
      'intellectual',
      'situational',
    ];

    for (final category in categories) {
      if (flirtContent[category] != null && flirtContent[category].isNotEmpty) {
        final randomIndex = _random.nextInt(flirtContent[category].length);
        result.add(flirtContent[category][randomIndex]);
      }
    }
    result.shuffle(_random);
    return result;
  }

  Map<String, dynamic>? getRandomFlirtLine() {
    if (_flirtLines.isEmpty) return null;
    int randomIndex = _random.nextInt(_flirtLines.length);
    return _flirtLines[randomIndex] as Map<String, dynamic>;
  }

  List<dynamic> getShuffledFlirtLines() {
    final List<dynamic> shuffledList = List.from(_flirtLines);
    shuffledList.shuffle(_random);
    return shuffledList;
  }

  Color getColorForCategory(String category) {
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
