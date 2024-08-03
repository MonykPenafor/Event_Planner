import 'package:flutter/material.dart';
import '../../components/custom_datefield.dart';
import '../../components/custom_textfield.dart';

class EventDetailsPage extends StatelessWidget {

  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController locationController;
  final TextEditingController themeController;
  final TextEditingController imageUrlController;
  final TextEditingController descriptionController;
  final TextEditingController numberOfAttendeesController;
  final TextEditingController typeController;
  final TextEditingController sizeRatingController;

  const EventDetailsPage({
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              CustomTextField(
                controller: titleController,
                labelText: 'Event Title',
                hintText: 'Enter the title of the event',
                prefixIcon: const Icon(Icons.event, color: Colors.blueGrey),
              ),

              const SizedBox(height: 16),
              CustomDateField(
                controller: dateController,
                labelText: 'Event Date',
                hintText: 'Select the date of the event',
                prefixIcon: const Icon(Icons.calendar_today, color: Colors.blueGrey),
              ),

              const SizedBox(height: 16),
              CustomTextField(
                controller: numberOfAttendeesController,
                labelText: 'Number of Attendees',
                hintText: 'Enter the number of attendees',
                prefixIcon: const Icon(Icons.people, color: Colors.blueGrey),
              ),

              const SizedBox(height: 16),
              CustomTextField(
                controller: locationController,
                labelText: 'Event Location',
                hintText: 'Enter the location of the event',
                prefixIcon: const Icon(Icons.location_on, color: Colors.blueGrey),
              ),

              const SizedBox(height: 16),
              CustomTextField(
                controller: themeController,
                labelText: 'Event Theme',
                hintText: 'Describe the theme of the event',
                prefixIcon: const Icon(Icons.palette, color: Colors.blueGrey),
              ),

              const SizedBox(height: 16),
              CustomTextField(
                controller: imageUrlController,
                labelText: 'Image URL',
                hintText: 'Enter the URL for the event image',
                prefixIcon: const Icon(Icons.image, color: Colors.blueGrey),
              ),

              const SizedBox(height: 16),
              CustomTextField(
                controller: descriptionController,
                labelText: 'Event Description',
                hintText: 'Provide a brief description of the event',
                prefixIcon: const Icon(Icons.description, color: Colors.blueGrey),
              ),

              const SizedBox(height: 16),
              CustomTextField(
                controller: typeController,
                labelText: 'Event Type',
                hintText: 'Specify the type of the event (e.g., Workshop, Conference)',
                prefixIcon: const Icon(Icons.category, color: Colors.blueGrey),
              ),
              
              const SizedBox(height: 16),
              CustomTextField(
                controller: sizeRatingController,
                labelText: 'Size Rating',
                hintText: 'Rate the expected size of the event (e.g., Small, Medium, Large)',
                prefixIcon: const Icon(Icons.star, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
