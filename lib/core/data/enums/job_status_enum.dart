enum JobStatus {
  pending('pending'),
  running('running'),
  completed('completed'),
  partiallyCompleted('partially_completed'),
  failed('failed'),
  paused('paused');

  final String value;
  const JobStatus(this.value);

  static JobStatus fromValue(String value) {
    return JobStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => JobStatus.pending,
    );
  }
}
