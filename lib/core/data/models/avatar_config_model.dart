class AvatarConfigModel {
  final String userId;
  final String stylePack;
  final int skinTone;
  final int hairStyle;
  final int hairColor;
  final int eyes;
  final int brows;
  final int mouth;
  final int accessory;
  final int outfit;
  final int bg;
  final DateTime updatedAt;

  AvatarConfigModel({
    required this.userId,
    this.stylePack = 'classic',
    this.skinTone = 2,
    this.hairStyle = 1,
    this.hairColor = 2,
    this.eyes = 1,
    this.brows = 1,
    this.mouth = 1,
    this.accessory = 0,
    this.outfit = 1,
    this.bg = 1,
    required this.updatedAt,
  });

  factory AvatarConfigModel.fromJson(Map<String, dynamic> json) {
    return AvatarConfigModel(
      userId: json['user_id'] as String,
      stylePack: json['style_pack'] as String? ?? 'classic',
      skinTone: json['skin_tone'] as int? ?? 2,
      hairStyle: json['hair_style'] as int? ?? 1,
      hairColor: json['hair_color'] as int? ?? 2,
      eyes: json['eyes'] as int? ?? 1,
      brows: json['brows'] as int? ?? 1,
      mouth: json['mouth'] as int? ?? 1,
      accessory: json['accessory'] as int? ?? 0,
      outfit: json['outfit'] as int? ?? 1,
      bg: json['bg'] as int? ?? 1,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'style_pack': stylePack,
      'skin_tone': skinTone,
      'hair_style': hairStyle,
      'hair_color': hairColor,
      'eyes': eyes,
      'brows': brows,
      'mouth': mouth,
      'accessory': accessory,
      'outfit': outfit,
      'bg': bg,
    };
  }
}
