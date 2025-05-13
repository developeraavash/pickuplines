class FlirtLine {
  final int id;
  final List<String> lines; // support multiple lines
  final String category;
  final List<String> tags;

  FlirtLine({
    required this.id,
    required this.lines,
    required this.category,
    required this.tags,
  });

  factory FlirtLine.fromJson(Map<String, dynamic> json) {
    // Support either "line" as a single string or "lines" as list:
    List<String> extractedLines;
    if (json['lines'] != null) {
      extractedLines = List<String>.from(json['lines']);
    } else if (json['line'] != null) {
      extractedLines = [json['line']];
    } else {
      extractedLines = [];
    }

    return FlirtLine(
      id: json['id'],
      lines: extractedLines,
      category: json['category'],
      tags: List<String>.from(json['tags']),
    );
  }
}

