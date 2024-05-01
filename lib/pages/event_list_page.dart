import 'package:event_planner/pages/event_detail_page.dart';
import 'package:flutter/material.dart';

class EventListPage extends StatelessWidget {
  const EventListPage
({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => const EventDetailPage(),));
        },
        child: const Text(
          "+", 
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
}