import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstLineController with ChangeNotifier {
  List<dynamic> _categories = [];
  bool _isLoading = true;
  int _selectedIndex = 0;

  List<dynamic> get categories => _categories;
  bool get isLoading => _isLoading;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    try {
      final String data = await rootBundle.loadString(
        'assets/data/all/a2.json',
      );

      final jsonResult = json.decode(data);
      final List<dynamic> categoriesList =
          jsonResult['categories'] as List<dynamic>;

      _categories = categoriesList;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading categories: $e');
      _categories = [];
      _isLoading = false;
      notifyListeners();
    }
  }

  IconData getIconFromString(String iconName) {
    switch (iconName) {
      case 'coffee_rounded':
        return Icons.coffee_rounded;
      case 'restaurant_rounded':
        return Icons.restaurant_rounded;
      case 'palette_rounded':
        return Icons.palette_rounded;
      case 'park_rounded':
        return Icons.park_rounded;
      default:
        return Icons.star;
    }
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
