import 'package:event_planner/pages/event/event_budget_page.dart';
import 'package:event_planner/pages/event/event_details_page.dart';
import 'package:event_planner/pages/event/event_toDoList_page.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/pages/event/event_guests_page.dart'; 
import 'package:event_planner/pages/event/event_itinerary_page.dart'; 

class EventNavigationPage extends StatefulWidget {
  const EventNavigationPage({Key? key}) : super(key: key);

  @override
  _EventNavigationPageState createState() => _EventNavigationPageState();
}

class _EventNavigationPageState extends State<EventNavigationPage> {
  int _selectedIndex = 0; // The index of the selected item

  // List of widgets to display when a tab is selected
  final List<Widget> _pages = [
    const EventDetailsPage(),
    const EventGuestsPage(),
    const EventToDoList(),
    const EventItineraryPage(),
    const EventBudgetPage(),
  ];

  // Function to build navigation items
  Widget _buildNavItem({required String label, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(label,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.blue : Colors.black,
            fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        
        // Custom top navigation bar within the AppBar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(label: "Details", index: 0),
              _buildNavItem(label: "Guests", index: 1),
              _buildNavItem(label: "To Do List", index: 2),
              _buildNavItem(label: "Itinerary", index: 3),
              _buildNavItem(label: "Budget", index: 4),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex], // Display the selected page
    );
  }
}
