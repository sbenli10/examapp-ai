class MockAttemptQuestionModel {
  final String id;
  final String mockAttemptId;
  final String userId;
  final String examId;
  final String questionId;
  final int orderNo;
  final String? selectedAnswer;
  final bool? isCorrect;
  final bool isBlank;
  final int timeSpentSeconds;
  final DateTime createdAt;

  MockAttemptQuestionModel({
    required this.id,
    required this.mockAttemptId,
    required this.userId,
    required this.examId,
    required this.questionId,
    this.orderNo = 1,
    this.selectedAnswer,
    this.isCorrect,
    this.isBlank = false,
    this.timeSpentSeconds = 0,
    required this.createdAt,
  });

  factory MockAttemptQuestionModel.fromJson(Map<String, dynamic> json) {
    return MockAttemptQuestionModel(
      id: json['id'] as String,
      mockAttemptId: json['mock_attempt_id'] as String,
      userId: json['user_id'] as String,
      examId: json['exam_id'] as String,
      questionId: json['question_id'] as String,
      orderNo: json['order_no'] as int? ?? 1,
      selectedAnswer: json['selected_answer'] as String?,
      isCorrect: json['is_correct'] as bool?,
      isBlank: json['is_blank'] as bool? ?? false,
      timeSpentSeconds: json['time_spent_seconds'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mock_attempt_id': mockAttemptId,
      'user_id': userId,
      'exam_id': examId,
      'question_id': questionId,
      'order_no': orderNo,
      'selected_answer': selectedAnswer,
      'is_correct': isCorrect,
      'is_blank': isBlank,
      'time_spent_seconds': timeSpentSeconds,
    };
  }
}
