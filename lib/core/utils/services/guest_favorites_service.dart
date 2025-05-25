import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GuestFavoritesService {
  static const String _guestFavoritesKey = 'guest_favorites';

  // Get saved lines for guest user
  static Future<List<Map<String, dynamic>>> getSavedLines() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedLinesJson = prefs.getString(_guestFavoritesKey);
      
      if (savedLinesJson == null) return [];
      
      final List<dynamic> decoded = json.decode(savedLinesJson);
      return List<Map<String, dynamic>>.from(decoded);
    } catch (e) {
      print('Error getting guest saved lines: $e');
      return [];
    }
  }

  // Save line for guest user
  static Future<void> saveLine(Map<String, dynamic> line) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentLines = await getSavedLines();
      
      // Check if line already exists
      if (currentLines.any((saved) => saved['line'] == line['line'])) {
        return; // Line already saved
      }

      // Add new line with timestamp and generated ID
      currentLines.add({
        ...line,
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'savedAt': DateTime.now().toIso8601String(),
      });

      await prefs.setString(_guestFavoritesKey, json.encode(currentLines));
    } catch (e) {
      print('Error saving guest line: $e');
      rethrow;
    }
  }

  // Remove line for guest user
  static Future<void> removeLine(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentLines = await getSavedLines();
      
      currentLines.removeWhere((line) => line['id'] == id);
      
      await prefs.setString(_guestFavoritesKey, json.encode(currentLines));
    } catch (e) {
      print('Error removing guest line: $e');
      rethrow;
    }
  }

  // Clear all saved lines for guest user
  static Future<void> clearSavedLines() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_guestFavoritesKey);
    } catch (e) {
      print('Error clearing guest saved lines: $e');
      rethrow;
    }
  }
}
