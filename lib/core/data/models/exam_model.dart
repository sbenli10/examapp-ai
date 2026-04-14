class ExamModel {
  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;

  ExamModel({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
