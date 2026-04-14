enum MockType {
  mini('mini'),
  branch('branch'),
  full('full');

  final String value;
  const MockType(this.value);

  static MockType fromValue(String value) {
    return MockType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MockType.mini,
    );
  }
}
