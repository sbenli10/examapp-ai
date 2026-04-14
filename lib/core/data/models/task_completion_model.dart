class TaskCompletionModel {
  final String id;
  final String taskId;
  final String userId;
  final String examId;
  final int awardedPoints;
  final DateTime completedAt;
  final Map<String, dynamic> meta;

  TaskCompletionModel({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.examId,
    this.awardedPoints = 0,
    required this.completedAt,
    this.meta = const {},
  });

  factory TaskCompletionModel.fromJson(Map<String, dynamic> json) {
    return TaskCompletionModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      userId: json['user_id'] as String,
      examId: json['exam_id'] as String,
      awardedPoints: json['awarded_points'] as int? ?? 0,
      completedAt: DateTime.parse(json['completed_at'] as String),
      meta: json['meta'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'user_id': userId,
      'exam_id': examId,
      'awarded_points': awardedPoints,
      'meta': meta,
    };
  }
}
