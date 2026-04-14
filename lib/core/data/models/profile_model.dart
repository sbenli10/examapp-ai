class ProfileModel {
  final String id;
  final String userId;
  final String email;
  final String examType;
  final int? targetScore;
  final DateTime createdAt;
  final String nickname;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.email,
    required this.examType,
    this.targetScore,
    required this.createdAt,
    required this.nickname,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      email: json['email'] as String,
      examType: json['exam_type'] as String,
      targetScore: json['target_score'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      nickname: json['nickname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'email': email,
      'exam_type': examType,
      'target_score': targetScore,
      'nickname': nickname,
    };
  }

  /// For upsert — excludes auto-generated fields like id and created_at
  Map<String, dynamic> toUpsertJson() {
    return {
      'user_id': userId,
      'email': email,
      'exam_type': examType,
      'target_score': targetScore,
      'nickname': nickname,
    };
  }
}
