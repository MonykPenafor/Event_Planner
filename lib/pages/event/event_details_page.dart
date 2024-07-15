import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final TextEditingController titleController;

  const EventDetailsPage({super.key, required this.titleController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Event Title',
            ),
          ),
          // Add other input fields as needed
        ],
      ),
    );
  }
}
