class QuizModel {
  final String defaultText;
  final String image;
  final List<String> options;
  final int correctAnswerIndex;
  final int id;

  QuizModel({
    required this.id,
    required this.defaultText,
    required this.image,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? 0,
      defaultText: json['defaulttext'] ?? '',
      image: json['image'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctAnswerIndex: json['correctAnswerIndex'] ?? 0,
    );
  }
}
