import 'package:flutter/material.dart';
import '../../components/custom_datefield.dart';
import '../../components/custom_textfield.dart';

class EventDetailsPage extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController locationController;
  final TextEditingController themeController;
  final TextEditingController imageUrlController;
  final TextEditingController descriptionController;
  final TextEditingController numberOfAttendeesController;
  final TextEditingController typeController;
  final TextEditingController sizeRatingController;

  EventDetailsPage({
    super.key,
    required this.titleController,
    required this.dateController,
    required this.locationController,
    required this.themeController,
    required this.imageUrlController,
    required this.descriptionController,
    required this.numberOfAttendeesController,
    required this.typeController,
    required this.sizeRatingController,
  });

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();

}

class _EventDetailsPageState extends State<EventDetailsPage> {

  String selectedSize = 'choose';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                controller: widget.titleController,
                labelText: 'Event Title',
                hintText: 'Enter the title of the event',
                icon: Icons.event,
              ),

              CustomTextField(
                controller: widget.descriptionController,
                labelText: 'Description',
                hintText: 'Provide a brief description of the event',
                icon: Icons.description,
              ),

              CustomDateField(
                controller: widget.dateController,
                labelText: 'Date',
                hintText: 'Select the date of the event',
                icon: Icons.calendar_today,
              ),

              CustomTextField(
                controller: widget.numberOfAttendeesController,
                labelText: 'Number of Attendees',
                hintText: 'Enter the number of attendees',
                icon: Icons.people,
              ),

              CustomTextField(
                controller: widget.locationController,
                labelText: 'Event Location',
                hintText: 'Enter the location of the event',
                icon: Icons.location_on,
              ),

              CustomTextField(
                controller: widget.typeController,
                labelText: 'Event Type',
                hintText: 'Specify the type of the event (e.g., Workshop, Conference)',
                icon: Icons.category,
              ),

              CustomTextField(
                controller: widget.themeController,
                labelText: 'Event Theme',
                hintText: 'Describe the theme of the event',
                icon: Icons.palette,
              ),

              CustomTextField(
                controller: widget.sizeRatingController,
                labelText: 'Event Size Classification',
                hintText: 'Rate the expected size of the event (e.g., Small, Medium, Large)',
                icon: Icons.star,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
