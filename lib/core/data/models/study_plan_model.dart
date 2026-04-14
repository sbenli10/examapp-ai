class StudyPlanModel {
  final String id;
  final String userId;
  final String examId;
  final String title;
  final String planVersion;
  final String createdBy;
  final Map<String, dynamic> meta;
  final DateTime startsOn;
  final DateTime? endsOn;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudyPlanModel({
    required this.id,
    required this.userId,
    required this.examId,
    this.title = 'Kişisel Çalışma Planı',
    this.planVersion = 'v1',
    this.createdBy = 'ai',
    this.meta = const {},
    required this.startsOn,
    this.endsOn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyPlanModel.fromJson(Map<String, dynamic> json) {
    return StudyPlanModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      examId: json['exam_id'] as String,
      title: json['title'] as String? ?? 'Kişisel Çalışma Planı',
      planVersion: json['plan_version'] as String? ?? 'v1',
      createdBy: json['created_by'] as String? ?? 'ai',
      meta: json['meta'] as Map<String, dynamic>? ?? {},
      startsOn: DateTime.parse(json['starts_on'] as String),
      endsOn: json['ends_on'] != null
          ? DateTime.parse(json['ends_on'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'exam_id': examId,
      'title': title,
      'plan_version': planVersion,
      'created_by': createdBy,
      'meta': meta,
      'starts_on': startsOn.toIso8601String().split('T').first,
      'ends_on': endsOn?.toIso8601String().split('T').first,
    };
  }
}
