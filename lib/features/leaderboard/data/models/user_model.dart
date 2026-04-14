class UserModel {
  /// The id of the user (user_id from profiles)
  final String id;

  /// The nickname of the user
  final String name;

  /// When the profile was created
  final DateTime createdAt;

  /// The exam type the user is preparing for
  final String examType;

  /// The email of the user
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.examType,
    required this.email,
  });

  /// Use this when loading data from supabase profiles table
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['user_id'] as String,
      name: map['nickname'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      examType: map['exam_type'] as String,
      email: map['email'] as String,
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, createdAt: $createdAt, examType: $examType)';
}
