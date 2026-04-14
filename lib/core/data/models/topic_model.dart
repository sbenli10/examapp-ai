class TopicModel {
  final String id;
  final String? subjectId;
  final String name;
  final DateTime? createdAt;
  final String? sectionName;
  final int? priority;
  final int? targetQuestionCount;

  TopicModel({
    required this.id,
    this.subjectId,
    required this.name,
    this.createdAt,
    this.sectionName,
    this.priority,
    this.targetQuestionCount,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'] as String,
      subjectId: json['subject_id'] as String?,
      name: json['name'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      sectionName: json['section_name'] as String?,
      priority: json['priority'] as int?,
      targetQuestionCount: json['target_question_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'name': name,
      'section_name': sectionName,
      'priority': priority,
      'target_question_count': targetQuestionCount,
    };
  }
}
