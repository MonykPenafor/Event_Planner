import 'package:event_planner/pages/calendar_page.dart';
import 'package:event_planner/pages/event_list_page.dart';
import 'package:event_planner/pages/toDoList_page.dart';
import 'package:flutter/material.dart';

import 'analytics_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),

      ),
      
      body: [
        const EventListPage(),   //representa a posição zero da lista
        const ToDoListPage(),     
        const CalendarPage(),   
        AnalyticsPage(),     
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        destinations:  const [
          // NavigationDestination(
          //   icon: Image.asset('assets/icons/star.png'),
          //   label: 'Events',
          // ),
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
        ],
      ),
    );
  }
}
