import 'dart:convert';
import 'package:pickuplines/features/quiz/models/quiz_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class QuizProvider with ChangeNotifier {
  List<QuizModel> _quizList = [];
  List<int?> _userSelectedIndexList = [];
  int _correctAnswersCount = 0;
  int _currentIndex = 0;

  List<QuizModel> get quizList => _quizList;
  List<int?> get userSelectedIndexList => _userSelectedIndexList;
  int get correctAnswersCount => _correctAnswersCount;
  int get currentIndex => _currentIndex;

  Future<void> loadJsonData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data.json');
      final jsonData = json.decode(jsonString) as List<dynamic>;

      _quizList =
          jsonData.map((quizJson) => QuizModel.fromJson(quizJson)).toList();
      _quizList.shuffle();
      _userSelectedIndexList = List<int?>.filled(_quizList.length, null);
      _currentIndex = 0; // Ensure starting index is reset
      _correctAnswersCount = 0; // Reset score when loading new data
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading JSON data: $e');
      }
      _quizList = [];
      _userSelectedIndexList = [];
      _correctAnswersCount = 0;
      _currentIndex = 0;
      notifyListeners();
    }
  }

  void selectOption(int optionIndex) {
    if (_currentIndex >= _quizList.length ||
        _userSelectedIndexList[_currentIndex] != null) {
      return;
    }

    _userSelectedIndexList[_currentIndex] = optionIndex;
    if (_quizList[_currentIndex].correctAnswerIndex == optionIndex) {
      _correctAnswersCount++;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < _quizList.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  bool isLastQuestion() {
    return _currentIndex >= _quizList.length - 1;
  }

  void resetQuiz() {
    _currentIndex = 0;
    _correctAnswersCount = 0;
    _userSelectedIndexList = List<int?>.filled(_quizList.length, null);
    notifyListeners();
  }
}
