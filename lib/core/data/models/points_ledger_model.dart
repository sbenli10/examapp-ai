import '../enums/points_ref_type_enum.dart';

class PointsLedgerModel {
  final String id;
  final String userId;
  final String examId;
  final int points;
  final String reason;
  final PointsRefType refType;
  final String? refId;
  final String? note;
  final DateTime createdAt;

  PointsLedgerModel({
    required this.id,
    required this.userId,
    required this.examId,
    required this.points,
    required this.reason,
    this.refType = PointsRefType.manual,
    this.refId,
    this.note,
    required this.createdAt,
  });

  factory PointsLedgerModel.fromJson(Map<String, dynamic> json) {
    return PointsLedgerModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      examId: json['exam_id'] as String,
      points: json['points'] as int,
      reason: json['reason'] as String,
      refType: PointsRefType.fromValue(json['ref_type'] as String),
      refId: json['ref_id'] as String?,
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'exam_id': examId,
      'points': points,
      'reason': reason,
      'ref_type': refType.value,
      'ref_id': refId,
      'note': note,
    };
  }
}
