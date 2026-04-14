class QuestionDbModel {
  final String id;
  final String? examId;
  final String? subjectId;
  final String? topicId;
  final String questionText;
  final String? optionA;
  final String? optionB;
  final String? optionC;
  final String? optionD;
  final String? optionE;
  final String? correctAnswer;
  final String? difficulty;
  final String? imageUrl;
  final DateTime? createdAt;
  final String? normalizedStem;
  final String? source;
  final String? generationJobId;
  final String? measurementFocus;
  final bool isVerified;
  final String? verifiedBy;
  final DateTime? verifiedAt;

  QuestionDbModel({
    required this.id,
    this.examId,
    this.subjectId,
    this.topicId,
    required this.questionText,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.optionE,
    this.correctAnswer,
    this.difficulty,
    this.imageUrl,
    this.createdAt,
    this.normalizedStem,
    this.source,
    this.generationJobId,
    this.measurementFocus,
    this.isVerified = false,
    this.verifiedBy,
    this.verifiedAt,
  });

  factory QuestionDbModel.fromJson(Map<String, dynamic> json) {
    return QuestionDbModel(
      id: json['id'] as String,
      examId: json['exam_id'] as String?,
      subjectId: json['subject_id'] as String?,
      topicId: json['topic_id'] as String?,
      questionText: json['question_text'] as String,
      optionA: json['option_a'] as String?,
      optionB: json['option_b'] as String?,
      optionC: json['option_c'] as String?,
      optionD: json['option_d'] as String?,
      optionE: json['option_e'] as String?,
      correctAnswer: json['correct_answer'] as String?,
      difficulty: json['difficulty'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      normalizedStem: json['normalized_stem'] as String?,
      source: json['source'] as String?,
      generationJobId: json['generation_job_id'] as String?,
      measurementFocus: json['measurement_focus'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      verifiedBy: json['verified_by'] as String?,
      verifiedAt: json['verified_at'] != null
          ? DateTime.parse(json['verified_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_id': examId,
      'subject_id': subjectId,
      'topic_id': topicId,
      'question_text': questionText,
      'option_a': optionA,
      'option_b': optionB,
      'option_c': optionC,
      'option_d': optionD,
      'option_e': optionE,
      'correct_answer': correctAnswer,
      'difficulty': difficulty,
      'image_url': imageUrl,
      'normalized_stem': normalizedStem,
      'source': source,
      'generation_job_id': generationJobId,
      'measurement_focus': measurementFocus,
      'is_verified': isVerified,
      'verified_by': verifiedBy,
    };
  }
}
