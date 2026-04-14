import '../enums/daily_task_type_enum.dart';
import '../enums/task_status_enum.dart';

class DailyTaskModel {
  final String id;
  final String planId;
  final String userId;
  final String examId;
  final DateTime taskDate;
  final DailyTaskType taskType;
  final String title;
  final String description;
  final String? subjectId;
  final String? topicId;
  final int? targetQuestionCount;
  final String? targetMockType;
  final int? targetDurationSeconds;
  final int pointsReward;
  final TaskStatus status;
  final int progressCurrent;
  final int progressTarget;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyTaskModel({
    required this.id,
    required this.planId,
    required this.userId,
    required this.examId,
    required this.taskDate,
    required this.taskType,
    required this.title,
    this.description = '',
    this.subjectId,
    this.topicId,
    this.targetQuestionCount,
    this.targetMockType,
    this.targetDurationSeconds,
    this.pointsReward = 0,
    this.status = TaskStatus.pending,
    this.progressCurrent = 0,
    this.progressTarget = 0,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DailyTaskModel.fromJson(Map<String, dynamic> json) {
    return DailyTaskModel(
      id: json['id'] as String,
      planId: json['plan_id'] as String,
      userId: json['user_id'] as String,
      examId: json['exam_id'] as String,
      taskDate: DateTime.parse(json['task_date'] as String),
      taskType: DailyTaskType.fromValue(json['task_type'] as String),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      subjectId: json['subject_id'] as String?,
      topicId: json['topic_id'] as String?,
      targetQuestionCount: json['target_question_count'] as int?,
      targetMockType: json['target_mock_type'] as String?,
      targetDurationSeconds: json['target_duration_seconds'] as int?,
      pointsReward: json['points_reward'] as int? ?? 0,
      status: TaskStatus.fromValue(json['status'] as String),
      progressCurrent: json['progress_current'] as int? ?? 0,
      progressTarget: json['progress_target'] as int? ?? 0,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_id': planId,
      'user_id': userId,
      'exam_id': examId,
      'task_date': taskDate.toIso8601String().split('T').first,
      'task_type': taskType.value,
      'title': title,
      'description': description,
      'subject_id': subjectId,
      'topic_id': topicId,
      'target_question_count': targetQuestionCount,
      'target_mock_type': targetMockType,
      'target_duration_seconds': targetDurationSeconds,
      'points_reward': pointsReward,
      'status': status.value,
      'progress_current': progressCurrent,
      'progress_target': progressTarget,
    };
  }
}
