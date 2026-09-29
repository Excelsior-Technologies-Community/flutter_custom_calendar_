# 📅 Flutter Custom Calendar 2

A customizable Flutter calendar widget that provides **date selection, range selection, event indicators, holiday locking, schedule view, date picker, and time picker** functionality in a single calendar widget.

Designed for easy integration into Flutter applications with a simple and flexible API.

## 🚀 Features

- 📅 Single date selection
- 🔄 Date range selection
- 🔵 Event indicators
- 🔒 Holiday locking
- 📋 Schedule view
- 📆 Date picker
- 🕐 Time picker
- ◀️ Previous month navigation
- ▶️ Next month navigation
- 🎯 Initial date support
- 📢 Date selection callbacks
- 📢 Range selection callbacks
- 📢 Date and time callbacks

## 🎬 Demo

<p align="center">
  <img src="assets/demo1.gif" width="250" alt="Flutter Custom Calendar 2 Demo">
</p>

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_custom_calendar2: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Git Installation

You can also install the package directly from GitHub:

```yaml
dependencies:
  flutter_custom_calendar2:
    git:
      url: https://github.com/shaikhsufiyan0143-pixel/flutter_custom_calendar.git
      ref: stage
```

## 🛠 Usage

### Import the Package

```dart
import 'package:flutter_custom_calendar2/flutter_custom_calendar2.dart';
```

### Basic Calendar

```dart
CustomCalendar(
  onDateSelected: (date) {
    print('Selected Date: $date');
  },
)
```

### Calendar with Events and Holidays

```dart
final List<CalendarEvent> events = [
  CalendarEvent(
    date: DateTime(2026, 9, 29, 10, 30),
    title: 'Team Meeting',
    description: 'Project discussion',
  ),
];

final List<CalendarHoliday> holidays = [
  CalendarHoliday(
    date: DateTime(2026, 10, 2),
    title: 'Holiday',
  ),
];

CustomCalendar(
  events: events,
  holidays: holidays,
  onDateSelected: (date) {
    print('Selected Date: $date');
  },
)
```

### Range Selection

Enable range selection using `enableRangePicker`:

```dart
CustomCalendar(
  enableRangePicker: true,
  onRangeSelected: (range) {
    print('Start Date: ${range.start}');
    print('End Date: ${range.end}');
  },
)
```

### Date and Time Selection

Enable the time picker using `enableTimePicker`:

```dart
CustomCalendar(
  enableTimePicker: true,
  onDateTimeSelected: (dateTime) {
    print('Selected Date & Time: $dateTime');
  },
)
```

## 🎨 CustomCalendar API

| Property | Type | Description |
|----------|------|-------------|
| `initialDate` | `DateTime?` | Initial date displayed by the calendar |
| `events` | `List<CalendarEvent>` | Calendar events |
| `holidays` | `List<CalendarHoliday>` | Calendar holidays |
| `enableRangePicker` | `bool` | Enables date range selection |
| `enableTimePicker` | `bool` | Enables time selection |
| `onDateSelected` | `Function(DateTime)` | Called when a date is selected |
| `onRangeSelected` | `Function(CalendarRange)` | Called when a range is selected |
| `onDateTimeSelected` | `Function(DateTime)` | Called when date and time are selected |

## 📅 CalendarEvent

`CalendarEvent` represents an event associated with a specific date.

```dart
CalendarEvent(
  date: DateTime(2026, 9, 29, 10, 30),
  title: 'Team Meeting',
  description: 'Project discussion',
)
```

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `date` | `DateTime` | Event date and time |
| `title` | `String` | Event title |
| `description` | `String?` | Optional event description |

## 🎉 CalendarHoliday

`CalendarHoliday` represents a holiday that can be locked from normal date selection.

```dart
CalendarHoliday(
  date: DateTime(2026, 10, 2),
  title: 'Holiday',
)
```

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `date` | `DateTime` | Holiday date |
| `title` | `String` | Holiday title |

## 🔄 CalendarRange

`CalendarRange` represents a selected date range.

```dart
CalendarRange(
  start: DateTime(2026, 9, 1),
  end: DateTime(2026, 9, 10),
)
```

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `start` | `DateTime?` | Range start date |
| `end` | `DateTime?` | Range end date |

## 🧩 Complete Example

```dart
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
      title: 'Flutter Custom Calendar 2',
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
          onDateSelected: (date) {
            print('Selected Date: $date');
          },
          onRangeSelected: (range) {
            print(
              'Selected Range: ${range.start} - ${range.end}',
            );
          },
          onDateTimeSelected: (dateTime) {
            print('Selected Date & Time: $dateTime');
          },
        ),
      ),
    );
  }
}
```

## 📁 Project Structure

```text
flutter_custom_calendar2/
│
├── assets/
│   └── demo1.gif
│
├── example2/
│   ├── android/
│   ├── ios/
│   ├── lib/
│   ├── test/
│   ├── pubspec.yaml
│   └── ...
│
├── lib/
│   ├── src/
│   │   ├── models/
│   │   │   ├── calendar_event.dart
│   │   │   ├── calendar_holiday.dart
│   │   │   └── calendar_range.dart
│   │   │
│   │   ├── utils/
│   │   │   └── calendar_utils.dart
│   │   │
│   │   └── widgets/
│   │       └── custom_calendar.dart
│   │
│   └── flutter_custom_calendar2.dart
│
├── test/
├── CHANGELOG.md
├── LICENSE
├── README.md
├── analysis_options.yaml
└── pubspec.yaml
```

## 📋 Requirements

- Flutter SDK
- Dart SDK
- Flutter 3.x or later

## 🛠 Supported Platforms

- Android
- iOS
- Web
- Windows
- macOS
- Linux

## 📄 License

MIT License

Copyright (c) 2026 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## 👨‍💻 Developed By

**Excelsior Technologies**

Built with ❤️ using Flutter and Dart.
