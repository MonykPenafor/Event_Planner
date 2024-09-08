import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/event.dart';
import '../../services/event_services.dart';
import '../../services/user_services.dart';

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
      // Obtenha os serviços de eventos e usuário do Provider
      final eventServices = Provider.of<EventServices>(context, listen: false);
      final userServices = Provider.of<UserServices>(context, listen: false);
      
      final userId = userServices.appUser?.id;
      if (userId == null) {
        // Se o userId for nulo, não carregue os eventos
        return;
      }

      // Fetch eventos do Firebase
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
  List<Event> events = selectedEvents[day] ?? [];
  print('Events for $day: $events');
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
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.circle,
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
          // Exibindo os eventos para o dia selecionado
          ..._getEventsForDay(_selectedDay).map(
            (event) => ListTile(
              title: Text(event.title ?? 'No Title'),
              subtitle: Text(event.description ?? 'No Description'),
            ),
          ),
        ],
      ),
    );
  }
}
