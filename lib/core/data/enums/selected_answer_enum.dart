enum SelectedAnswer {
  a('A'),
  b('B'),
  c('C'),
  d('D'),
  e('E');

  final String value;
  const SelectedAnswer(this.value);

  static SelectedAnswer? fromValue(String? value) {
    if (value == null) return null;
    return SelectedAnswer.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SelectedAnswer.a,
    );
  }
}
