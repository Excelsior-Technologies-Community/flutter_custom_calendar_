class CalendarUtils {
  static bool isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  static bool isDateInRange(
      DateTime date,
      DateTime start,
      DateTime end,
      ) {
    final currentDate = DateTime(date.year, date.month, date.day);
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);

    return !currentDate.isBefore(startDate) &&
        !currentDate.isAfter(endDate);
  }

  static int daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  static DateTime firstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime lastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }
}