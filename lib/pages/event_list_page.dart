import 'package:flutter/material.dart';

import 'event_page.dart';

class EventListPage extends StatelessWidget {
  const EventListPage
({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => const EventPage(),));
        },
        child: const Text(
          "+", 
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
}