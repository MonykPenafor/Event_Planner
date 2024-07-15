import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/event.dart';
import 'package:event_planner/pages/event/event_budget_page.dart';
import 'package:event_planner/pages/event/event_details_page.dart';
import 'package:event_planner/pages/event/event_toDoList_page.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/pages/event/event_guests_page.dart';
import 'package:event_planner/pages/event/event_itinerary_page.dart';
import 'package:provider/provider.dart';

import '../../components/custom_snackbar.dart';
import '../../services/user_services.dart';

class EventNavigationPage extends StatefulWidget {
  const EventNavigationPage({super.key});

  @override
  State<EventNavigationPage> createState() => _EventNavigationPageState();
}

class _EventNavigationPageState extends State<EventNavigationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _nGuestsController = TextEditingController();

  final Event _event = Event();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _nGuestsController.dispose();
    super.dispose();
  }

  void saveEventData(String? userId) {
  _event.title = _titleController.text;
  _event.numberOfGuests = int.tryParse(_nGuestsController.text) ?? 0;
  _event.userId = userId;

  // Save data to Firestore
  FirebaseFirestore.instance.collection('events').add(_event.toJson()).then((docRef) {
    // Update the document with the generated ID
    _event.id = docRef.id;

    // Use set with merge to update the event with the ID
    FirebaseFirestore.instance.collection('events').doc(_event.id).set(_event.toJson(), SetOptions(merge: true)).then((_) {
      CustomSnackBar.show(
        context,
        'Event saved successfully with ID: ${_event.id}',
        const Color.fromARGB(255, 88, 155, 0),
      );
      Navigator.pushNamed(context, "/mainNav");
    });
  }).catchError((error) {
    CustomSnackBar.show(
      context,
      'Failed to save event: $error',
      Colors.red,
    );
  });
}


 @override
  Widget build(BuildContext context) {
    return Consumer<UserServices>(
      builder: (context, userServices, child) {
        if (userServices.appUser == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Event Details"),
            bottom: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(text: "Details"),
                Tab(text: "Guests"),
                Tab(text: "To Do List"),
                Tab(text: "Itinerary"),
                Tab(text: "Budget"),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              EventDetailsPage(titleController: _titleController),
              EventGuestsPage(guestsController: _nGuestsController),
              const EventToDoList(),
              const EventItineraryPage(),
              const EventBudgetPage(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => saveEventData(userServices.appUser!.id!), // Pass user ID to save method
            child: const Icon(Icons.save),
          ),
        );
      },
    );
  }
}
