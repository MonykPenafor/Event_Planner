import 'package:event_planner/pages/event/event_budget_page.dart';
import 'package:event_planner/pages/event/event_details_page.dart';
import 'package:event_planner/pages/event/event_toDoList_page.dart';
import 'package:event_planner/services/event_services.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/pages/event/event_guests_page.dart';
import 'package:event_planner/pages/event/event_itinerary_page.dart';
import 'package:provider/provider.dart';
import '../../services/user_services.dart';

class EventNavigationPage extends StatefulWidget {
  const EventNavigationPage({super.key});

  @override
  State<EventNavigationPage> createState() => _EventNavigationPageState();
}

class _EventNavigationPageState extends State<EventNavigationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberOfAttendeesController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _sizeRatingController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    _titleController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _numberOfAttendeesController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _themeController.dispose();
    _typeController.dispose();
    _sizeRatingController.dispose();

    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Consumer2<UserServices, EventServices>(
      builder: (context, userServices, eventServices, child) {
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
              EventDetailsPage(
                titleController: _titleController, 
                dateController: _dateController, 
                locationController: _locationController,
                descriptionController: _descriptionController,
                imageUrlController: _imageUrlController,
                sizeRatingController: _sizeRatingController,
                themeController: _themeController,
                typeController: _typeController,
                ),

              EventGuestsPage(
                numberOfAttendeesController: _numberOfAttendeesController),

              const EventToDoList(),
              const EventItineraryPage(),
              const EventBudgetPage(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await eventServices.createEvent(
                userId: userServices.appUser?.id, 
                title: _titleController.text,  
                date: DateTime.tryParse(_dateController.text),
                location: _locationController.text,
                numberOfAttendees: int.tryParse(_numberOfAttendeesController.text), 
                description: _descriptionController.text,
                imageUrl: _imageUrlController.text,
                sizeRating: _sizeRatingController.text,
                theme: _themeController.text,
                type: _typeController.text,
              );

              // Show snackbar based on the result
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result['message']),
                  backgroundColor: result['success'] ? Colors.green : Colors.red,
                ),
              );

              Navigator.pushNamed(context, '/mainNav');
            },
            child: const Icon(Icons.save),
          ),
        );
      },
    );
  }
}
