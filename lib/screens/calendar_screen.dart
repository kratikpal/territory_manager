import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_background.dart';
import '../widgets/common_drawer.dart';


DateTime _focusedDay=DateTime.now();
DateTime? _selectedDay=DateTime.now();

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return  CommonBackground(
      child: Scaffold(
        appBar: CommonAppBar(
          actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/Back_attendance.png'),
            padding: const EdgeInsets.only(right: 20),
          ),
        ],
          title: const Text('Calendar'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        drawer: const CommonDrawer(),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              CalendarWidget(),
              EventsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calendar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Month/Year',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TableCalendar(
              firstDay: DateTime.utc(1900, 5, 1),
              lastDay: DateTime.utc(2900, 5, 1),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Events List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            EventItem(
              date: '10-06-2024',
              event: 'Meeting with Territory Manager',
            ),
            SizedBox(height: 10),
            EventItem(
              date: '10-06-2024',
              event: 'Sales Data Review',
            ),
          ],
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final String date;
  final String event;

  const EventItem({super.key, required this.date, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date: $date'),
          Text(
            'Event: $event',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Add view details functionality here
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue[800],
            ),
            child: const Text('VIEW DETAILS'),
          ),
        ],
      ),
    );
  }
}