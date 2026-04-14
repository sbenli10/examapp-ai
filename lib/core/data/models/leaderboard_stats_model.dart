import '../enums/period_type_enum.dart';

class LeaderboardStatsModel {
  final String id;
  final String userId;
  final String examId;
  final PeriodType periodType;
  final DateTime periodStart;
  final DateTime periodEnd;
  final int totalPoints;
  final double totalNet;
  final int solvedQuestionsCount;
  final int correctCount;
  final int wrongCount;
  final int blankCount;
  final int mockCount;
  final int? rankPosition;
  final DateTime updatedAt;

  LeaderboardStatsModel({
    required this.id,
    required this.userId,
    required this.examId,
    required this.periodType,
    required this.periodStart,
    required this.periodEnd,
    this.totalPoints = 0,
    this.totalNet = 0,
    this.solvedQuestionsCount = 0,
    this.correctCount = 0,
    this.wrongCount = 0,
    this.blankCount = 0,
    this.mockCount = 0,
    this.rankPosition,
    required this.updatedAt,
  });

  factory LeaderboardStatsModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardStatsModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      examId: json['exam_id'] as String,
      periodType: PeriodType.fromValue(json['period_type'] as String),
      periodStart: DateTime.parse(json['period_start'] as String),
      periodEnd: DateTime.parse(json['period_end'] as String),
      totalPoints: json['total_points'] as int? ?? 0,
      totalNet: (json['total_net'] as num?)?.toDouble() ?? 0,
      solvedQuestionsCount: json['solved_questions_count'] as int? ?? 0,
      correctCount: json['correct_count'] as int? ?? 0,
      wrongCount: json['wrong_count'] as int? ?? 0,
      blankCount: json['blank_count'] as int? ?? 0,
      mockCount: json['mock_count'] as int? ?? 0,
      rankPosition: json['rank_position'] as int?,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'exam_id': examId,
      'period_type': periodType.value,
      'period_start': periodStart.toIso8601String().split('T').first,
      'period_end': periodEnd.toIso8601String().split('T').first,
      'total_points': totalPoints,
      'total_net': totalNet,
      'solved_questions_count': solvedQuestionsCount,
      'correct_count': correctCount,
      'wrong_count': wrongCount,
      'blank_count': blankCount,
      'mock_count': mockCount,
      'rank_position': rankPosition,
    };
  }
}
