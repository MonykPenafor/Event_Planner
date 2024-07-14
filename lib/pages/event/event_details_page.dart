import 'package:event_planner/pages/home/main_navigation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/event_list_services.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final TextEditingController _titleController = TextEditingController();
  // final TextEditingController _numberOfPeopleController = TextEditingController();
  // final TextEditingController _venueController = TextEditingController();
  // final TextEditingController _cateringController = TextEditingController();
  // final TextEditingController _descriptionController = TextEditingController();
  // final TextEditingController _themeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final EventListServices _eventListServices = EventListServices();

  
  @override
  void dispose() {
    _titleController.dispose();
    // _numberOfPeopleController.dispose();
    // _venueController.dispose();
    // _cateringController.dispose();
    // _descriptionController.dispose();
    // _themeController.dispose();
    super.dispose();
  }





  void _createEvent() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String title = _titleController.text;

        var result = await _eventListServices.createEvent(title, user.uid);
        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );

         // Navigate to EventListPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainNavigationPage()),
          );

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'])),
          );
        }
      }
    }
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Event Title',
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the event title';
                }
                return null;
              },
            ),
            // const SizedBox(height: 16),
            // TextFormField(
            //   controller: _numberOfPeopleController,
            //   decoration: const InputDecoration(
            //     hintText: 'Number of People Attending',
            //     border: InputBorder.none,
            //   ),
            //   keyboardType: TextInputType.number,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter number of attendees';
            //     }
            //     return null;
            //   },
            // ),
            // const SizedBox(height: 16),
            // TextFormField(
            //   controller: _venueController,
            //   decoration: const InputDecoration(
            //     hintText: 'Venue',
            //     border: InputBorder.none,
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter the venue';
            //     }
            //     return null;
            //   },
            // ),
            // const SizedBox(height: 16),
            // TextFormField(
            //   controller: _cateringController,
            //   decoration: const InputDecoration(
            //     hintText: 'Catering Services',
            //     border: InputBorder.none,
            //   ),
            // ),
            // const SizedBox(height: 16),
            // TextFormField(
            //   controller: _descriptionController,
            //   decoration: const InputDecoration(
            //     hintText: 'Description',
            //     border: InputBorder.none,
            //   ),
            //   maxLines: 3,
            // ),
            // const SizedBox(height: 16),
            // TextFormField(
            //   controller: _themeController,
            //   decoration: const InputDecoration(
            //     hintText: 'Theme',
            //     border: InputBorder.none,
            //   ),
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createEvent, 
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}