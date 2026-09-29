class CalendarEvent {
  final DateTime date;
  final String title;
  final String? description;

  CalendarEvent({
    required this.date,
    required this.title,
    this.description,
  });
}