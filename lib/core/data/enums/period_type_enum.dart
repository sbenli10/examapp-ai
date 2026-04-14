enum PeriodType {
  weekly('weekly'),
  monthly('monthly'),
  allTime('all_time');

  final String value;
  const PeriodType(this.value);

  static PeriodType fromValue(String value) {
    return PeriodType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PeriodType.weekly,
    );
  }
}
