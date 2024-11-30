class Reminder {
  final int id;
  final String title;
  final DateTime selectedDate;
  bool isCompleted;

  Reminder({
    required this.id,
    required this.title,
    required this.selectedDate,
    this.isCompleted = false,
  });
}
