class SubjectModel {
  final String id;
  final String? examId;
  final String name;
  final DateTime? createdAt;
  final String? sectionName;

  SubjectModel({
    required this.id,
    this.examId,
    required this.name,
    this.createdAt,
    this.sectionName,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] as String,
      examId: json['exam_id'] as String?,
      name: json['name'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      sectionName: json['section_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_id': examId,
      'name': name,
      'section_name': sectionName,
    };
  }
}
