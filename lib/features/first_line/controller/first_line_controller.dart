import 'package:flutter/material.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';

class FirstLineController with ChangeNotifier {
  List<dynamic> _categories = [];
  bool _isLoading = true;
  int _selectedIndex = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<dynamic> get categories => _categories;
  bool get isLoading => _isLoading;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    try {
      debugPrint('Loading categories from Firebase...');
      final QuerySnapshot snapshot =
          await _firestore.collection('first_line_categories').get();

      final List<dynamic> categoriesList =
          snapshot.docs.map((doc) => doc.data()).toList();
      debugPrint('Found ${categoriesList.length} categories from Firebase');

      _categories = categoriesList;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading categories from Firebase: $e');
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
