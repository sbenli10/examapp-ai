import '../enums/app_role_enum.dart';

class UserRoleModel {
  final String userId;
  final AppRole role;
  final DateTime createdAt;

  UserRoleModel({
    required this.userId,
    required this.role,
    required this.createdAt,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
      userId: json['user_id'] as String,
      role: AppRole.fromValue(json['role'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'role': role.value,
    };
  }
}
