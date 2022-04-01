import 'package:flutter/material.dart';
import 'package:memory_notebook/Screens/PlanPage/PlansScreens/PlansAdd.dart';
import 'package:memory_notebook/data/CalendarDbHelper.dart';

import 'package:memory_notebook/models/Calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../MyBackGround/PlanBackground.dart';

class TableCalendarPage extends StatefulWidget {
  const TableCalendarPage({Key? key}) : super(key: key);

  @override
  State<TableCalendarPage> createState() => _TableCalendarState();
}

class _TableCalendarState extends State<TableCalendarPage> {
  var format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<Calendar>>? selectedEvents;
  List<Calendar>? calendars;

  var dbHelper = CalendarDbHelper();
  int calendarsCount = 0;

  @override
  void initState() {
    getCalendars();
    selectedEvents = {};
  }

  List<Calendar> _getEventsfromDay(DateTime date) {
    return selectedEvents![date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PLANLARIN"),
        backgroundColor: Colors.indigo[300],
      ),
      body: PlanBackGround(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                      color: Colors.deepPurpleAccent[700],
                    ),
                    weekdayStyle: TextStyle(
                      color: Colors.deepPurpleAccent[700],
                    ),
                  ),
                  focusedDay: focusedDay,
                  firstDay: DateTime(
                      focusedDay.year, focusedDay.month - 3, focusedDay.day),
                  lastDay: DateTime(
                      focusedDay.year, focusedDay.month + 3, focusedDay.day),
                  onPageChanged: (focusDay) {
                    focusedDay = focusDay;
                  },
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  eventLoader: _getEventsfromDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekVisible: true,
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },
                  onDaySelected: (selectDay, focusDay) {
                    if (!isSameDay((selectDay), selectedDay)) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                    }
                  },
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                    todayDecoration: BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    decoration: BoxDecoration(
                      color: Color(0xFF7986CB),
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    leftChevronIcon: Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.black, size: 15),
                    rightChevronIcon: Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.black, size: 15),
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                ..._getEventsfromDay(selectedDay).map((Calendar calendar) {
                  return ListTile(
                    title: Text(
                      calendar.name,
                    ),
                    subtitle: Text(calendar.descriptions),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PlansAdd()));
        },
        backgroundColor: Colors.indigo[300],
        label: Text("Plan Ekle"),
        icon: Icon(Icons.add),
      ),
    );
  }

  void getCalendars() {
    var calendarsFuture = dbHelper.getCalendars();
    calendarsFuture.then((data) {
      setState(() {
        this.calendars = data;
        calendarsCount = data.length;
      });
    });
  }
}
