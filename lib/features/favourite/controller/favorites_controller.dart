import 'package:flutter/material.dart';
import 'package:pickuplines/core/utils/services/favorite_ser.dart';

class FavoritesController with ChangeNotifier {
  List<Map<String, dynamic>> _savedLines = [];
  List<Map<String, dynamic>> _chipCategories = [];
  bool _isLoading = true;
  int _selectedChipIndex = 0;

  List<Map<String, dynamic>> get savedLines => _savedLines;
  List<Map<String, dynamic>> get chipCategories => _chipCategories;
  bool get isLoading => _isLoading;
  int get selectedChipIndex => _selectedChipIndex;

  void setSelectedChipIndex(int index) {
    _selectedChipIndex = index;
    notifyListeners();
  }

  Future<void> loadSavedLines() async {
    try {
      final lines = await FavoritesService.getSavedLines();

      // Create categories from saved lines
      final Map<String, List<Map<String, dynamic>>> categorized = {};
      for (var line in lines) {
        final category = line['category'];
        if (!categorized.containsKey(category)) {
          categorized[category] = [];
        }
        categorized[category]!.add(line);
      }

      // Create chip categories
      final List<Map<String, dynamic>> chips = [];
      categorized.forEach((category, categoryLines) {
        chips.add({'label': category, 'color': _getCategoryColor(category)});
      });

      _savedLines = lines;
      _chipCategories = chips;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading saved lines: $e');
      _savedLines = [];
      _chipCategories = [];
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Map<String, dynamic> line) async {
    try {
      await FavoritesService.saveLine(line);
      await loadSavedLines(); // Reload to refresh the list
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await FavoritesService.removeLine(id);
      await loadSavedLines(); // Reload to refresh the list
    } catch (e) {
      debugPrint('Error removing favorite: $e');
    }
  }

  Color _getCategoryColor(String category) {
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
