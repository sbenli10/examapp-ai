class QuestionAttemptModel {
  final String id;
  final String userId;
  final String questionId;
  final String examId;
  final String? subjectId;
  final String? topicId;
  final String? selectedAnswer;
  final bool isCorrect;
  final bool isBlank;
  final bool usedAiHelp;
  final int timeSpentSeconds;
  final int pointsAwarded;
  final double netDelta;
  final int attemptNo;
  final DateTime createdAt;

  QuestionAttemptModel({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.examId,
    this.subjectId,
    this.topicId,
    this.selectedAnswer,
    required this.isCorrect,
    this.isBlank = false,
    this.usedAiHelp = false,
    this.timeSpentSeconds = 0,
    this.pointsAwarded = 0,
    this.netDelta = 0,
    this.attemptNo = 1,
    required this.createdAt,
  });

  factory QuestionAttemptModel.fromJson(Map<String, dynamic> json) {
    return QuestionAttemptModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      questionId: json['question_id'] as String,
      examId: json['exam_id'] as String,
      subjectId: json['subject_id'] as String?,
      topicId: json['topic_id'] as String?,
      selectedAnswer: json['selected_answer'] as String?,
      isCorrect: json['is_correct'] as bool,
      isBlank: json['is_blank'] as bool? ?? false,
      usedAiHelp: json['used_ai_help'] as bool? ?? false,
      timeSpentSeconds: json['time_spent_seconds'] as int? ?? 0,
      pointsAwarded: json['points_awarded'] as int? ?? 0,
      netDelta: (json['net_delta'] as num?)?.toDouble() ?? 0,
      attemptNo: json['attempt_no'] as int? ?? 1,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'question_id': questionId,
      'exam_id': examId,
      'subject_id': subjectId,
      'topic_id': topicId,
      'selected_answer': selectedAnswer,
      'is_correct': isCorrect,
      'is_blank': isBlank,
      'used_ai_help': usedAiHelp,
      'time_spent_seconds': timeSpentSeconds,
      'points_awarded': pointsAwarded,
      'net_delta': netDelta,
      'attempt_no': attemptNo,
    };
  }
}
