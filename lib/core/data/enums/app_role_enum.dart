enum AppRole {
  student('student'),
  admin('admin'),
  moderator('moderator');

  final String value;
  const AppRole(this.value);

  static AppRole fromValue(String value) {
    return AppRole.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AppRole.student,
    );
  }
}
