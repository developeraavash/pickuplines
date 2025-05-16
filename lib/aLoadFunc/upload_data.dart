import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:logger/logger.dart';

final Logger logger = Logger();

Future<void> uploadCategoryQuestions(
  String language,
  String type,
  String category,
  String collection,
  String filePath,
  int order,
) async {
  try {
    logger.w('Loading JSON from: $filePath');
    final String jsonContent = await rootBundle.loadString(filePath);
    final Map<String, dynamic> jsonData = json.decode(jsonContent);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();
    int documentsInBatch = 0;

    // Extract the flirt_content section
    final flirtContent = jsonData['flirt_content'];

    // Process each category
    for (var category in flirtContent.keys) {
      logger.w('Processing category: $category');
      final lines = flirtContent[category] as List;

      for (var data in lines) {
        if (data is Map<String, dynamic>) {
          final docRef = firestore.collection('flirt_content').doc();
          // Make sure category is stored in lowercase
          data['category'] = data['category'].toString().toLowerCase();
          batch.set(docRef, {
            ...data,
            'language': language,
            'type': type,
            'order': order,
            'timestamp': FieldValue.serverTimestamp(),
          });
          documentsInBatch++;

          // Commit batch when it reaches 500 documents (Firestore limit)
          if (documentsInBatch >= 500) {
            await batch.commit();
            logger.w('Committed batch of $documentsInBatch documents');
            documentsInBatch = 0;
          }
        }
      }
    }

    // Commit any remaining documents
    if (documentsInBatch > 0) {
      await batch.commit();
      logger.w('Committed final batch of $documentsInBatch documents');
    }

    logger.w('Successfully uploaded data from $filePath');
  } catch (e, stack) {
    logger.w('Upload error for $filePath: $e');
    logger.w('Stack trace: $stack');
  }
}

Future<void> uploadCategoryData() async {
  try {
    logger.w('Loading category data from a2.json');
    final String jsonContent = await rootBundle.loadString(
      'assets/data/all/a2.json',
    );
    final Map<String, dynamic> jsonData = json.decode(jsonContent);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    // Get the categories array
    final List<dynamic> categories = jsonData['categories'];

    for (var category in categories) {
      final docRef = firestore.collection('first_line_categories').doc();
      batch.set(docRef, category);
    }

    await batch.commit();
    logger.w(
      'Successfully uploaded ${categories.length} categories to Firebase',
    );
  } catch (e, stack) {
    logger.w('Error uploading categories: $e');
    logger.w('Stack trace: $stack');
  }
}

Future<void> uploadAllData() async {
  try {
    logger.w("Starting data upload to Firebase...");

    // Upload flirt lines
    // await uploadCategoryQuestions();

    // Upload categories
    await uploadCategoryData();

    logger.w("All data uploaded successfully");
  } catch (e, stack) {
    logger.w('Upload error: $e');
    logger.w('Stack trace: $stack');
  }
}
