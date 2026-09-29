import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar2/flutter_custom_calendar2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarDemo(),
    );
  }
}

class CalendarDemo extends StatefulWidget {
  const CalendarDemo({super.key});

  @override
  State<CalendarDemo> createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<CalendarDemo> {
  final List<CalendarEvent> events = [
    CalendarEvent(
      date: DateTime(2026, 9, 29, 10, 30),
      title: 'Team Meeting',
      description: 'Project discussion',
    ),
    CalendarEvent(
      date: DateTime(2026, 9, 29, 14, 00),
      title: 'Client Call',
      description: 'Client project discussion',
    ),
    CalendarEvent(
      date: DateTime(2026, 10, 5, 11, 00),
      title: 'Project Review',
      description: 'Review project progress',
    ),
  ];

  final List<CalendarHoliday> holidays = [
    CalendarHoliday(
      date: DateTime(2026, 10, 2),
      title: 'Holiday',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: CustomCalendar(
          events: events,
          holidays: holidays,
          enableRangePicker: true,
          enableTimePicker: true,
          onDateSelected: (date) {},
          onRangeSelected: (range) {},
          onDateTimeSelected: (dateTime) {},
        ),
      ),
    );
  }
}