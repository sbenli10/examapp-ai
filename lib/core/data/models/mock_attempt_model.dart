class MockAttemptModel {
  final String id;
  final String userId;
  final String examId;
  final String? subjectId;
  final String? topicId;
  final String mockType;
  final String title;
  final int questionCount;
  final int correctCount;
  final int wrongCount;
  final int blankCount;
  final double netScore;
  final int pointsAwarded;
  final int durationSeconds;
  final DateTime startedAt;
  final DateTime completedAt;
  final DateTime createdAt;

  MockAttemptModel({
    required this.id,
    required this.userId,
    required this.examId,
    this.subjectId,
    this.topicId,
    required this.mockType,
    required this.title,
    required this.questionCount,
    this.correctCount = 0,
    this.wrongCount = 0,
    this.blankCount = 0,
    this.netScore = 0,
    this.pointsAwarded = 0,
    this.durationSeconds = 0,
    required this.startedAt,
    required this.completedAt,
    required this.createdAt,
  });

  factory MockAttemptModel.fromJson(Map<String, dynamic> json) {
    return MockAttemptModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      examId: json['exam_id'] as String,
      subjectId: json['subject_id'] as String?,
      topicId: json['topic_id'] as String?,
      mockType: json['mock_type'] as String,
      title: json['title'] as String,
      questionCount: json['question_count'] as int,
      correctCount: json['correct_count'] as int? ?? 0,
      wrongCount: json['wrong_count'] as int? ?? 0,
      blankCount: json['blank_count'] as int? ?? 0,
      netScore: (json['net_score'] as num?)?.toDouble() ?? 0,
      pointsAwarded: json['points_awarded'] as int? ?? 0,
      durationSeconds: json['duration_seconds'] as int? ?? 0,
      startedAt: DateTime.parse(json['started_at'] as String),
      completedAt: DateTime.parse(json['completed_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'exam_id': examId,
      'subject_id': subjectId,
      'topic_id': topicId,
      'mock_type': mockType,
      'title': title,
      'question_count': questionCount,
      'correct_count': correctCount,
      'wrong_count': wrongCount,
      'blank_count': blankCount,
      'net_score': netScore,
      'points_awarded': pointsAwarded,
      'duration_seconds': durationSeconds,
      'started_at': startedAt.toIso8601String(),
      'completed_at': completedAt.toIso8601String(),
    };
  }
}
