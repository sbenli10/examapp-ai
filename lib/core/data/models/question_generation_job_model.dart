import '../enums/difficulty_enum.dart';
import '../enums/job_status_enum.dart';
import '../enums/question_style_enum.dart';

class QuestionGenerationJobModel {
  final String id;
  final String examId;
  final String subjectId;
  final String topicId;
  final String? sectionName;
  final Difficulty difficulty;
  final QuestionStyle questionStyle;
  final int targetCount;
  final int batchSize;
  final int generatedCount;
  final int insertedCount;
  final int duplicateCount;
  final int failedCount;
  final JobStatus status;
  final String promptVersion;
  final String? notes;
  final String? lastError;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;

  QuestionGenerationJobModel({
    required this.id,
    required this.examId,
    required this.subjectId,
    required this.topicId,
    this.sectionName,
    this.difficulty = Difficulty.medium,
    this.questionStyle = QuestionStyle.standard,
    required this.targetCount,
    this.batchSize = 10,
    this.generatedCount = 0,
    this.insertedCount = 0,
    this.duplicateCount = 0,
    this.failedCount = 0,
    this.status = JobStatus.pending,
    this.promptVersion = 'v1',
    this.notes,
    this.lastError,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.startedAt,
    this.completedAt,
  });

  factory QuestionGenerationJobModel.fromJson(Map<String, dynamic> json) {
    return QuestionGenerationJobModel(
      id: json['id'] as String,
      examId: json['exam_id'] as String,
      subjectId: json['subject_id'] as String,
      topicId: json['topic_id'] as String,
      sectionName: json['section_name'] as String?,
      difficulty: Difficulty.fromValue(json['difficulty'] as String? ?? 'medium'),
      questionStyle: QuestionStyle.fromValue(json['question_style'] as String? ?? 'standard'),
      targetCount: json['target_count'] as int,
      batchSize: json['batch_size'] as int? ?? 10,
      generatedCount: json['generated_count'] as int? ?? 0,
      insertedCount: json['inserted_count'] as int? ?? 0,
      duplicateCount: json['duplicate_count'] as int? ?? 0,
      failedCount: json['failed_count'] as int? ?? 0,
      status: JobStatus.fromValue(json['status'] as String? ?? 'pending'),
      promptVersion: json['prompt_version'] as String? ?? 'v1',
      notes: json['notes'] as String?,
      lastError: json['last_error'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'] as String)
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_id': examId,
      'subject_id': subjectId,
      'topic_id': topicId,
      'section_name': sectionName,
      'difficulty': difficulty.value,
      'question_style': questionStyle.value,
      'target_count': targetCount,
      'batch_size': batchSize,
      'prompt_version': promptVersion,
      'notes': notes,
      'created_by': createdBy,
    };
  }
}
