class UserProgressModel {
  final String id;
  final String? userId;
  final String? topicId;
  final int correctCount;
  final int wrongCount;
  final DateTime? updatedAt;

  UserProgressModel({
    required this.id,
    this.userId,
    this.topicId,
    this.correctCount = 0,
    this.wrongCount = 0,
    this.updatedAt,
  });

  factory UserProgressModel.fromJson(Map<String, dynamic> json) {
    return UserProgressModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      topicId: json['topic_id'] as String?,
      correctCount: json['correct_count'] as int? ?? 0,
      wrongCount: json['wrong_count'] as int? ?? 0,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'topic_id': topicId,
      'correct_count': correctCount,
      'wrong_count': wrongCount,
    };
  }
}
