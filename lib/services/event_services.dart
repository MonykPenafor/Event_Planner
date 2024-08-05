import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/app_user.dart';
import 'package:event_planner/services/task_services.dart';
import 'package:flutter/foundation.dart';
import '../models/event.dart';
import '../models/task.dart';

class EventServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _collectionRef => _firestore.collection("events");

  final TaskServices _taskServices = TaskServices();

  Future<Map<String, dynamic>> createEvent({
    String? title,
    String? userId,
    int? numberOfAttendees,
    String? location,
    DateTime? date,
    String? theme,
    String? imageUrl,
    String? description,
    String? type,
    String? sizeRating,
    List<Task>? tasks}) 
      
    async {
      try {

        Event event = Event(
          title: title,
          userId: userId,
          numberOfAttendees: numberOfAttendees, 
          location: location,
          date: date,
          theme: theme,
          imageUrl: imageUrl,
          description: description,
          type: type,
          sizeRating: sizeRating,
        );

        // Add the event and get the document reference
        DocumentReference docRef = await _collectionRef.add(event.toJson());

        // Set the event ID
        event.id = docRef.id;

        // update the document with the ID
        await _collectionRef.doc(event.id).set(event.toJson(), SetOptions(merge: true));

        if (tasks != null) {
          for (var task in tasks) {
            _taskServices.createTask(userId!, task, eventId: docRef.id);
          }
        }

        return {
          'success': true,
          'message': 'Event created successfully',
        };
      } 

      catch (e) {
        return {
          'success': false, 
          'message': 'Error creating event: $e'
        };
      }
    }


  Stream<QuerySnapshot> fetchEvents(AppUser? user) {

    String? userId = user!.id;
    return _collectionRef.where('userId', isEqualTo: userId).orderBy('title').snapshots();
  }


  Future<Map<String, dynamic>> deleteEvent(String? eventId) async {
    try {

      List<Task>? eventTasks = await _taskServices.fetchTasksListByEvent(eventId); 

      if(eventTasks.isNotEmpty){
        for (Task task in eventTasks) {
          await _taskServices.deleteTask(task.id);
        }
      }


      await _collectionRef.doc(eventId).delete();

      return {
        'success': true,
        'message': 'Event deleted',
      };
    } 
    catch (e) 
    {
      return {
        'success': false, 
        'message': 'Error deleting event: $e'};
    }
  }
}
