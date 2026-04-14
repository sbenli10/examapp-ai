class ProfilePhotoModel {
  final String userId;
  final String? photoUrl;
  final DateTime updatedAt;

  ProfilePhotoModel({
    required this.userId,
    this.photoUrl,
    required this.updatedAt,
  });

  factory ProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    return ProfilePhotoModel(
      userId: json['user_id'] as String,
      photoUrl: json['photo_url'] as String?,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'photo_url': photoUrl,
    };
  }
}
