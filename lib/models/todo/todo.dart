class TODO {
  final String id;
  final String title;
    bool isCompleted;
  final DateTime createdAt;

  TODO({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });
}
