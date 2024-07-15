import 'package:flutter/material.dart';

class EventGuestsPage extends StatelessWidget {
  final TextEditingController guestsController;

  const EventGuestsPage({super.key, required this.guestsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: guestsController,
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
