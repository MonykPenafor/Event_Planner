import 'package:event_planner/pages/budget_page.dart';
import 'package:event_planner/pages/event_todolist_page.dart';
import 'package:flutter/material.dart';
import 'details_page.dart'; // Replace with your actual page
import 'guests_page.dart'; // Replace with your actual page
import 'itinerary_page.dart'; // Replace with your actual page

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _selectedIndex = 0; // The index of the selected item

  // List of widgets to display when a tab is selected
  final List<Widget> _pages = [
    const DetailsPage(),
    const GuestsPage(),
    const EventToDoList(),
    const ItineraryPage(),
    const BudgetPage(),
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
          preferredSize: const Size.fromHeight(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(label: "Details", index: 0),
              _buildNavItem(label: "Guests", index: 1),
              _buildNavItem(label: "ToDo List", index: 2),
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
