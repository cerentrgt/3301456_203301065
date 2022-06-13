import 'package:flutter/material.dart';
import 'package:memory_notebook/Screens/PlanPage/PlansScreens/Events.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarPage extends StatefulWidget {
  const TableCalendarPage({Key? key}) : super(key: key);

  @override
  State<TableCalendarPage> createState() => _TableCalendarPageState();
}

class _TableCalendarPageState extends State<TableCalendarPage> {
  var format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<Events>>? selectedEvents;
  var eventController = TextEditingController();

  @override
  void dispose() {
    eventController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Events> _getEventsfromDay(DateTime date) {
    return selectedEvents![date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime(
                    focusedDay.year, focusedDay.month - 3, focusedDay.day),
                lastDay: DateTime(
                    focusedDay.year, focusedDay.month + 3, focusedDay.day),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: Colors.deepPurpleAccent[700],
                  ),
                  weekdayStyle: TextStyle(
                    color: Colors.deepPurpleAccent[700],
                  ),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: format,
                onDaySelected: (selectDay, focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
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
                onPageChanged: (focusDay) {
                  focusedDay = focusDay;
                },
                daysOfWeekVisible: true,
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                headerStyle: HeaderStyle(
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
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, events) => Container(
                    margin: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                eventLoader: _getEventsfromDay,
              ),
              ..._getEventsfromDay(selectedDay).map(
                (Events event) => ListTile(
                  title: Text(event.title),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Plan ekle"),
        backgroundColor: Colors.indigo[300],
        icon: Icon(Icons.add),
        onPressed: () => showAlertDialog(),
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Plan Ekle"),
            content: TextFormField(
              decoration: const InputDecoration(labelText: "Planın Nedir?"),
              controller: eventController,
              textCapitalization: TextCapitalization.words,
            ),
            actions: [
              TextButton(
                child: Text("Vazgeç"),
                onPressed: () {
                  return Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("Ekle"),
                onPressed: () {
                  if (eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents![selectedDay] != null) {
                      selectedEvents![selectedDay]?.add(
                        Events(title: eventController.text),
                      );
                    } else {
                      selectedEvents![selectedDay] = [
                        Events(title: eventController.text),
                      ];
                    }
                  }

                  Navigator.pop(context);
                  eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
