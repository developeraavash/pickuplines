import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadCategoryQuestions(
  String mainCollection,
  String mainDoc,
  String collection,
  String doc,
  String jsonAssetPath,
  int subCollectionIndex,
) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String jsonString = await rootBundle.loadString(jsonAssetPath);
  final dynamic jsonData = json.decode(jsonString);

  // Convert the data to a list regardless of input format
  List<Map<String, dynamic>> questions = [];
  
  if (jsonData is Map<String, dynamic>) {
    if (jsonData.containsKey('flirt_content')) {
      // Handle a1.json format
      final flirtContent = jsonData['flirt_content'] as Map<String, dynamic>;
      questions = flirtContent.values
          .expand((category) => (category as List).cast<Map<String, dynamic>>())
          .toList();
    } else if (jsonData.containsKey('categories')) {
      // Handle a2.json format
      final categories = jsonData['categories'] as List;
      questions = categories.expand((category) {
        final lines = category['lines'] as List<String>;
        return lines.map((line) => {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'line': line,
          'category': category['title'],
          'tags': [category['subtitle'].split(' ')[0].toLowerCase()]
        });
      }).toList();
    }
  } else if (jsonData is List) {
    questions = (jsonData as List).cast<Map<String, dynamic>>();
  } else {
    throw FormatException('Invalid JSON format: expected Map or List');
  }

  WriteBatch batch = firestore.batch();
  final questionsCollection = firestore
      .collection(mainCollection)
      .doc(mainDoc)
      .collection(collection)
      .doc(doc)
      .collection(subCollectionIndex.toString());

  for (var question in questions) {
    final id = question['id']?.toString() ?? 
        DateTime.now().millisecondsSinceEpoch.toString();
    final docRef = questionsCollection.doc(id);
    batch.set(docRef, question);
  }

  await batch.commit();
}

Future<void> uploadCategoryQuestions2(
  String mainCollection,
  String mainDoc,
  String collection,
  String doc,
  String jsonAssetPath,
  int subCollectionIndex,
) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String jsonString = await rootBundle.loadString(jsonAssetPath);
  final dynamic jsonData = json.decode(jsonString);

  // Convert the data to a list regardless of input format
  List<dynamic> questions;
  if (jsonData is Map) {
    // If it's a map, extract the data we need (assuming it's in a nested structure)
    questions =
        (jsonData['flirt_content'] as Map<String, dynamic>).values
            .expand((category) => category as List<dynamic>)
            .toList();
  } else if (jsonData is List) {
    questions = jsonData;
  } else {
    throw FormatException('Invalid JSON format: expected Map or List');
  }

  WriteBatch batch = firestore.batch();
  final questionsCollection = firestore
      .collection(mainCollection)
      .doc(mainDoc)
      .collection(collection)
      .doc(doc)
      .collection(subCollectionIndex.toString());

  for (var question in questions) {
    // Ensure each question has an id, generate one if missing
    final id =
        question['id']?.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString();
    final docRef = questionsCollection.doc(id);
    batch.set(docRef, question);
  }

  await batch.commit();
}
