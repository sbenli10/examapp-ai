enum Difficulty {
  easy('easy'),
  medium('medium'),
  hard('hard');

  final String value;
  const Difficulty(this.value);

  static Difficulty fromValue(String value) {
    return Difficulty.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Difficulty.medium,
    );
  }
}
