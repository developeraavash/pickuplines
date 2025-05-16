import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlirtServices with ChangeNotifier {
  List<dynamic> _flirtLines = [];
  List<dynamic> _topCategoryLines = [];
  bool _isLoading = true;
  final Random _random = Random();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<dynamic> get flirtLines => _flirtLines;
  List<dynamic> get topCategoryLines => _topCategoryLines;
  bool get isLoading => _isLoading;

  Future<void> loadFlirtContent() async {
    try {
      _isLoading = true;
      notifyListeners();

      final QuerySnapshot snapshot =
          await _firestore.collection('flirt_content').get();

      final List<String> categories = [
        'playful',
        'romantic',
        'cheeky',
        'intellectual',
        'situational',
      ];

      Map<String, List<dynamic>> categoryData = {};
      _flirtLines = [];

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final category = data['category'] as String;

        if (categories.contains(category.toLowerCase())) {
          if (!categoryData.containsKey(category.toLowerCase())) {
            categoryData[category.toLowerCase()] = [];
          }
          categoryData[category.toLowerCase()]!.add(data);
          _flirtLines.add(data);
        }
      }

      // Get one random line from each category for the top section
      _topCategoryLines = _getTopCategoryLinesFromCategories(categoryData);

      _isLoading = false;
      notifyListeners();
    } catch (e, stack) {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<dynamic> _getTopCategoryLinesFromCategories(
    Map<String, List<dynamic>> categoryData,
  ) {
    List<dynamic> result = [];
    final categories = categoryData.keys.toList();

    for (final category in categories) {
      if (categoryData[category]!.isNotEmpty) {
        final randomIndex = _random.nextInt(categoryData[category]!.length);
        result.add(categoryData[category]![randomIndex]);
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
