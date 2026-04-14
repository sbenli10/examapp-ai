class QuestionOptionModel {
  final String id;
  final String questionId;
  final String optionKey;
  final String optionText;
  final DateTime? createdAt;

  QuestionOptionModel({
    required this.id,
    required this.questionId,
    required this.optionKey,
    required this.optionText,
    this.createdAt,
  });

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) {
    return QuestionOptionModel(
      id: json['id'] as String,
      questionId: json['question_id'] as String,
      optionKey: json['option_key'] as String,
      optionText: json['option_text'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'option_key': optionKey,
      'option_text': optionText,
    };
  }
}
