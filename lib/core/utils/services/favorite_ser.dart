import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'guest_favorites_service.dart';

class FavoritesService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'favorites';

  static Future<List<Map<String, dynamic>>> getSavedLines() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Guest user
      return GuestFavoritesService.getSavedLines();
    } else {
      // Authenticated user
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
  }

  static Future<void> saveLine(Map<String, dynamic> line) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user == null) {
        // Guest user
        await GuestFavoritesService.saveLine(line);
        print('Saved line for guest user: ${line['line']}');
      } else {
        // Authenticated user
        await _firestore.collection(_collection).add({
          ...line,
          'savedAt': FieldValue.serverTimestamp(),
        });
        print('Saved line for authenticated user: ${line['line']}');
      }
    } on FirebaseException catch (e) {
      print('FirebaseException while saving line: ${e.message}');
      print('Error code: ${e.code}');
      print('Stack trace: ${e.stackTrace}');
      rethrow;
    } catch (e, stack) {
      print('Unexpected error while saving line: $e');
      print('Stack trace: $stack');
      rethrow;
    }
  }

  static Future<void> removeLine(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Guest user
      await GuestFavoritesService.removeLine(id);
    } else {
      // Authenticated user
      try {
        await _firestore.collection(_collection).doc(id).delete();
      } catch (e) {
        print('Error removing line: $e');
        rethrow;
      }
    }
  }
}
