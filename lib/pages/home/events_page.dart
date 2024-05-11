import 'package:flutter/material.dart';

import '../event/event_navigation_page.dart';

class EventsPage extends StatelessWidget {
  const EventsPage
({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => const EventNavigationPage(),));
        },
        child: const Text(
          "+", 
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
}