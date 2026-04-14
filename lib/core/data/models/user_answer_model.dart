class UserAnswerModel {
  final String id;
  final String? userId;
  final String? questionId;
  final String? selectedAnswer;
  final bool? isCorrect;
  final DateTime? createdAt;

  UserAnswerModel({
    required this.id,
    this.userId,
    this.questionId,
    this.selectedAnswer,
    this.isCorrect,
    this.createdAt,
  });

  factory UserAnswerModel.fromJson(Map<String, dynamic> json) {
    return UserAnswerModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      questionId: json['question_id'] as String?,
      selectedAnswer: json['selected_answer'] as String?,
      isCorrect: json['is_correct'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'question_id': questionId,
      'selected_answer': selectedAnswer,
      'is_correct': isCorrect,
    };
  }
}
