import 'package:event_planner/pages/home/calendar_page.dart';
import 'package:event_planner/pages/home/events_page.dart';
import 'package:event_planner/pages/home/toDoList_page.dart';
import 'package:flutter/material.dart';
import 'analytics_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatefulWidget {

  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        EventsPage(),
        const ToDoListPage(),
        const CalendarPage(),
        AnalyticsPage(),
        ProfilePage(),
      ]
      [_selectedIndex],

      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {setState(() { _selectedIndex = value;});},
        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.event_note_rounded),
            label: 'Events',
          ),

          NavigationDestination(
            icon: Icon(Icons.list_alt_rounded),
            label: 'To do List',
          ),

          NavigationDestination(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calendar',
          ),

          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analytics',
          ),
          
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
