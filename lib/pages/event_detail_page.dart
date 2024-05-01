import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [

          Image.asset('assets/images/festival.jpg'),
          const Text("data"),



        ],
        
        
      )      
    );
  }
}