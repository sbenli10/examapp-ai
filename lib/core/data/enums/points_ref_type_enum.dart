enum PointsRefType {
  manual('manual'),
  questionAttempt('question_attempt'),
  mockAttempt('mock_attempt'),
  taskCompletion('task_completion');

  final String value;
  const PointsRefType(this.value);

  static PointsRefType fromValue(String value) {
    return PointsRefType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PointsRefType.manual,
    );
  }
}
