import 'package:flutter/material.dart';

class EventGuestsPage extends StatelessWidget {
  final TextEditingController numberOfAttendeesController;

  const EventGuestsPage({super.key, required this.numberOfAttendeesController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: numberOfAttendeesController,
            decoration: const InputDecoration(
              labelText: 'Number of Guests',
            ),
          ),
          // Add other input fields as needed
        ],
      ),
    );
  }
}
