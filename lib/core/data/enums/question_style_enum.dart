enum QuestionStyle {
  standard('standard'),
  newGeneration('new_generation'),
  shortDrill('short_drill'),
  longParagraph('long_paragraph'),
  tableInterpretation('table_interpretation'),
  graphInterpretation('graph_interpretation');

  final String value;
  const QuestionStyle(this.value);

  static QuestionStyle fromValue(String value) {
    return QuestionStyle.values.firstWhere(
      (e) => e.value == value,
      orElse: () => QuestionStyle.standard,
    );
  }
}
