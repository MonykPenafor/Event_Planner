import 'package:event_planner/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/event.dart';
import '../../services/event_services.dart';
import '../../services/user_services.dart';
import '../event/event_navigation_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat _format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedEvents = {};
    _loadFirebaseEvents();
  }

  Future<void> _loadFirebaseEvents() async {
    try {
      final eventServices = Provider.of<EventServices>(context, listen: false);
      final userServices = Provider.of<UserServices>(context, listen: false);
      
      final userId = userServices.appUser?.id;
      if (userId == null) {
        return;
      }

      List<Event> firebaseEvents = await eventServices.fetchEventsList(userId);

      setState(() {
        selectedEvents = {};
        for (var event in firebaseEvents) {
          DateTime eventDate = DateTime(
            event.date!.year,
            event.date!.month,
            event.date!.day,
          );
          if (selectedEvents[eventDate] == null) {
            selectedEvents[eventDate] = [];
          }
          selectedEvents[eventDate]!.add(event);
        }
      });
    } catch (e) {
      print('Error loading events: $e');
    }
  }
  
  List<Event> _getEventsForDay(DateTime day) {
    DateTime normalizedDay = DateTime(day.year, day.month, day.day); 
    List<Event> events = selectedEvents[normalizedDay] ?? [];
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Calendar',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: _format,
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                _format = format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekVisible: true,

            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },

            selectedDayPredicate: (DateTime date) {
              return isSameDay(_selectedDay, date);
            },

            eventLoader: _getEventsForDay,

            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 117, 33),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 208, 0),
              ),
            ),

            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay).map(
                (event) => InkWell(
                  onTap: () {
                    
                    final taskServices = Provider.of<TaskServices>(context, listen: false);
                    taskServices.resetLocalTasks();

                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            EventNavigationPage(event: event)));

                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 20, 122, 170), // Cor viva e alegre
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3), // Sombra moderna
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title ?? 'No Title',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white, 
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          event.description ?? 'No Description',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),

        ],
      ),
    );
  }
}