enum DailyTaskType {
  questionSolving('question_solving'),
  mockExam('mock_exam'),
  review('review'),
  study('study');

  final String value;
  const DailyTaskType(this.value);

  static DailyTaskType fromValue(String value) {
    return DailyTaskType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => DailyTaskType.questionSolving,
    );
  }
}
