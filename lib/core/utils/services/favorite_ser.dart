import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'favorites';

  static Future<List<Map<String, dynamic>>> getSavedLines() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection(_collection).get();
      return snapshot.docs
          .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
          .toList();
    } catch (e) {
      print('Error getting saved lines: $e');
      return [];
    }
  }

  static Future<void> saveLine(Map<String, dynamic> line) async {
    try {
      // Create a new document with auto-generated ID
      await _firestore.collection(_collection).add({
        ...line,
        'savedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving line: $e');
      rethrow;
    }
  }

  static Future<void> removeLine(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      print('Error removing line: $e');
      rethrow;
    }
  }
}
