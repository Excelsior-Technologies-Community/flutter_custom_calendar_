import 'package:flutter/material.dart';

import '../models/calendar_event.dart';
import '../models/calendar_holiday.dart';
import '../models/calendar_range.dart';
import '../utils/calendar_utils.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime? initialDate;
  final List<CalendarEvent> events;
  final List<CalendarHoliday> holidays;

  final bool enableRangePicker;
  final bool enableTimePicker;

  final Function(DateTime)? onDateSelected;
  final Function(CalendarRange)? onRangeSelected;
  final Function(DateTime)? onDateTimeSelected;

  const CustomCalendar({
    super.key,
    this.initialDate,
    this.events = const [],
    this.holidays = const [],
    this.enableRangePicker = false,
    this.enableTimePicker = false,
    this.onDateSelected,
    this.onRangeSelected,
    this.onDateTimeSelected,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime currentMonth;

  DateTime? selectedDate;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();

    currentMonth = widget.initialDate ?? DateTime.now();
    selectedDate = widget.initialDate ?? DateTime.now();
    selectedDateTime = widget.initialDate ?? DateTime.now();
  }

  void previousMonth() {
    setState(() {
      currentMonth = DateTime(
        currentMonth.year,
        currentMonth.month - 1,
      );
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(
        currentMonth.year,
        currentMonth.month + 1,
      );
    });
  }

  List<DateTime> getCalendarDays() {
    final firstDay = CalendarUtils.firstDayOfMonth(currentMonth);

    final daysInMonth = CalendarUtils.daysInMonth(
      currentMonth.year,
      currentMonth.month,
    );

    final firstWeekday = firstDay.weekday;

    final days = <DateTime>[];

    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(
        firstDay.subtract(
          Duration(days: i),
        ),
      );
    }

    for (int i = 0; i < daysInMonth; i++) {
      days.add(
        DateTime(
          currentMonth.year,
          currentMonth.month,
          i + 1,
        ),
      );
    }

    while (days.length < 42) {
      days.add(
        days.last.add(
          const Duration(days: 1),
        ),
      );
    }

    return days;
  }

  bool hasEvent(DateTime date) {
    return widget.events.any(
          (event) => CalendarUtils.isSameDay(
        event.date,
        date,
      ),
    );
  }

  bool isHoliday(DateTime date) {
    return widget.holidays.any(
          (holiday) => CalendarUtils.isSameDay(
        holiday.date,
        date,
      ),
    );
  }

  bool isStartDate(DateTime date) {
    return startDate != null &&
        CalendarUtils.isSameDay(
          startDate!,
          date,
        );
  }

  bool isEndDate(DateTime date) {
    return endDate != null &&
        CalendarUtils.isSameDay(
          endDate!,
          date,
        );
  }

  bool isInRange(DateTime date) {
    if (startDate == null || endDate == null) {
      return false;
    }

    return CalendarUtils.isDateInRange(
      date,
      startDate!,
      endDate!,
    );
  }

  void selectDate(DateTime date) {
    if (isHoliday(date)) {
      return;
    }

    if (widget.enableRangePicker) {
      selectRange(date);
    } else {
      setState(() {
        selectedDate = date;
        selectedDateTime = date;
      });

      widget.onDateSelected?.call(date);
    }
  }

  void selectRange(DateTime date) {
    setState(() {
      if (startDate == null || endDate != null) {
        startDate = date;
        endDate = null;
      } else {
        if (date.isBefore(startDate!)) {
          endDate = startDate;
          startDate = date;
        } else {
          endDate = date;
        }
      }

      selectedDate = date;
    });

    if (startDate != null && endDate != null) {
      widget.onRangeSelected?.call(
        CalendarRange(
          start: startDate,
          end: endDate,
        ),
      );
    }
  }

  Future<void> selectDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) {
      return;
    }

    setState(() {
      selectedDate = date;
      currentMonth = date;

      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        selectedDateTime?.hour ?? 0,
        selectedDateTime?.minute ?? 0,
      );
    });

    widget.onDateSelected?.call(date);
  }

  Future<void> selectTimePicker() async {
    final currentTime = TimeOfDay.fromDateTime(
      selectedDateTime ?? DateTime.now(),
    );

    final time = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (time == null) {
      return;
    }

    final date = selectedDate ?? DateTime.now();

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      selectedDateTime = dateTime;
    });

    widget.onDateTimeSelected?.call(dateTime);
  }

  List<CalendarEvent> getSelectedDateEvents() {
    if (selectedDate == null) {
      return [];
    }

    return widget.events.where((event) {
      return CalendarUtils.isSameDay(
        event.date,
        selectedDate!,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final days = getCalendarDays();
    final selectedEvents = getSelectedDateEvents();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: previousMonth,
                icon: const Icon(
                  Icons.chevron_left,
                ),
              ),
              Text(
                '${_monthName(currentMonth.month)} ${currentMonth.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: nextMonth,
                icon: const Icon(
                  Icons.chevron_right,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              'Mon',
              'Tue',
              'Wed',
              'Thu',
              'Fri',
              'Sat',
              'Sun',
            ].map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 8),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (context, index) {
              final date = days[index];

              final isCurrentMonth =
                  date.month == currentMonth.month;

              final isSelected =
                  !widget.enableRangePicker &&
                      selectedDate != null &&
                      CalendarUtils.isSameDay(
                        selectedDate!,
                        date,
                      );

              final holiday = isHoliday(date);
              final event = hasEvent(date);
              final start = isStartDate(date);
              final end = isEndDate(date);
              final range = isInRange(date);

              return GestureDetector(
                onTap: isCurrentMonth && !holiday
                    ? () => selectDate(date)
                    : null,
                child: Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: start || end
                        ? Colors.blue
                        : range
                        ? Colors.blue.withValues(
                      alpha: 0.15,
                    )
                        : isSelected
                        ? Colors.blue
                        : holiday
                        ? Colors.grey.shade200
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          color: !isCurrentMonth
                              ? Colors.grey.shade400
                              : holiday
                              ? Colors.grey
                              : isSelected ||
                              start ||
                              end
                              ? Colors.white
                              : Colors.black,
                          fontWeight: isSelected ||
                              start ||
                              end
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),

                      if (event)
                        Positioned(
                          bottom: 5,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: isSelected ||
                                  start ||
                                  end
                                  ? Colors.white
                                  : Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),

                      if (holiday)
                        const Positioned(
                          top: 3,
                          right: 3,
                          child: Icon(
                            Icons.lock,
                            size: 10,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          if (widget.enableRangePicker)
            Row(
              children: [
                Expanded(
                  child: Text(
                    startDate == null
                        ? 'Start date'
                        : 'Start: ${startDate!.day}/${startDate!.month}/${startDate!.year}',
                  ),
                ),
                Expanded(
                  child: Text(
                    endDate == null
                        ? 'End date'
                        : 'End: ${endDate!.day}/${endDate!.month}/${endDate!.year}',
                  ),
                ),
              ],
            ),

          if (selectedDate != null &&
              selectedEvents.isNotEmpty) ...[
            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            ...selectedEvents.map(
                  (event) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    child: Icon(Icons.event),
                  ),
                  title: Text(event.title),
                  subtitle: event.description == null
                      ? null
                      : Text(event.description!),
                  trailing: Text(
                    '${event.date.hour.toString().padLeft(2, '0')}:${event.date.minute.toString().padLeft(2, '0')}',
                  ),
                );
              },
            ),
          ],

          if (widget.enableTimePicker) ...[
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: selectDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                    label: const Text('Date'),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: selectTimePicker,
                    icon: const Icon(
                      Icons.access_time,
                    ),
                    label: const Text('Time'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }
}