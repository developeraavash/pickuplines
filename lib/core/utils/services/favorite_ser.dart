import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FavoritesService {
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/favorites.json');
  }

  static Future<List<Map<String, dynamic>>> getSavedLines() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<Map<String, dynamic>>.from(json.decode(contents));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<void> saveLine(Map<String, dynamic> line) async {
    final savedLines = await getSavedLines();
    // Check if already saved
    if (!savedLines.any((l) => l['id'] == line['id'])) {
      savedLines.add(line);
      final file = await _getFile();
      await file.writeAsString(json.encode(savedLines));
    }
  }

  static Future<void> removeLine(String id) async {
    final savedLines = await getSavedLines();
    savedLines.removeWhere((line) => line['id'] == id);
    final file = await _getFile();
    await file.writeAsString(json.encode(savedLines));
  }
}
