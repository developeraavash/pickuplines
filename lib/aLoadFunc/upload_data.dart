import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future<void> uploadCategoryQuestions(
  String language,
  String type,
  String category,
  String collection,
  String filePath,
  int order,
) async {
  try {
    print('Loading JSON from: $filePath');
    final String jsonContent = await rootBundle.loadString(filePath);
    final Map<String, dynamic> jsonData = json.decode(jsonContent);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();
    int documentsInBatch = 0;

    // Extract the flirt_content section
    final flirtContent = jsonData['flirt_content'];

    // Process each category
    for (var category in flirtContent.keys) {
      print('Processing category: $category');
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
            print('Committed batch of $documentsInBatch documents');
            documentsInBatch = 0;
          }
        }
      }
    }

    // Commit any remaining documents
    if (documentsInBatch > 0) {
      await batch.commit();
      print('Committed final batch of $documentsInBatch documents');
    }

    print('Successfully uploaded data from $filePath');
  } catch (e, stack) {
    print('Upload error for $filePath: $e');
    print('Stack trace: $stack');
  }
}

Future<void> uploadCategoryQuestions2(
  String language,
  String type,
  String category,
  String collection,
  String filePath,
  int order,
) async {
  // Using the same implementation as uploadCategoryQuestions for consistency
  return uploadCategoryQuestions(
    language,
    type,
    category,
    collection,
    filePath,
    order,
  );
}

Future<void> uploadAllDCategoryQuestionsInEnglish() async {
  try {
    print("Starting upload to Firebase...");

    // Upload English content
    String filePath = 'assets/data/all/a1.json';
    await uploadCategoryQuestions(
      'en',
      'localization',
      "A",
      "data",
      filePath,
      1,
    );

    String filePath1 = 'assets/data/all/a2.json';
    await uploadCategoryQuestions2(
      'en',
      'localization',
      "A",
      "data",
      filePath1,
      2,
    );

    print("Upload completed successfully");
  } catch (e, stack) {
    print('Upload error: $e');
    print('Stack trace: $stack');
  }
}
