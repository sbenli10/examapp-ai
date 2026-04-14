class AiAnalysisModel {
  final String id;
  final String? userId;
  final Map<String, dynamic>? weakTopics;
  final String? recommendation;
  final DateTime? createdAt;
  final String? examId;

  AiAnalysisModel({
    required this.id,
    this.userId,
    this.weakTopics,
    this.recommendation,
    this.createdAt,
    this.examId,
  });

  factory AiAnalysisModel.fromJson(Map<String, dynamic> json) {
    return AiAnalysisModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      weakTopics: json['weak_topics'] as Map<String, dynamic>?,
      recommendation: json['recommendation'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      examId: json['exam_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'weak_topics': weakTopics,
      'recommendation': recommendation,
      'exam_id': examId,
    };
  }
}
