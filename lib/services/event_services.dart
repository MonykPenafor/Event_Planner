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

  Future<Map<String, dynamic>> saveEvent(Event event, String? userId, List<Task> tasks) async {
    
    dynamic result;

    try {
      if (event.id != null) 
      {
        result = await updateEvent(userId, event, tasks);
      } 
      else 
      {
        result = await createEvent(userId, event, tasks);
      }

      return {
        'success': true,
        'message': result,
      };
    } 
    catch (e) {
      return {'success': false, 'message': 'Error saving event: $e'};
    }
  }

  Future<String> createEvent(String? userId, Event event, List<Task>? tasks) async {
      // Add the event and get the document reference
      DocumentReference docRef = await _collectionRef.add(event.toJson());

      // Set the event ID
      event.id = docRef.id;

      // update the document with the ID
      await _collectionRef
          .doc(event.id)
          .set(event.toJson(), SetOptions(merge: true));

      if (tasks != null) {
        for (var task in tasks) {
          await _taskServices.createTask(userId!, task, eventId: docRef.id);
        }
      }

      return "Event created successfully";
  }

  Future<String> updateEvent(String? userId, Event event, List<Task>? tasks) async {
      await _collectionRef.doc(event.id).set(event.toJson(), SetOptions(merge: true));

      if (tasks != null) {
        for (var task in tasks) {
          if (task.id != null) {
          _taskServices.updateTask(userId!, task);
          }
          else{
          _taskServices.createTask(userId!, task, eventId: event.id!);
          }
        }
      }

      return "Event updated successfully";
  }

  Stream<QuerySnapshot> fetchEvents(AppUser? user) {
    String? userId = user!.id;
    return _collectionRef
        .where('userId', isEqualTo: userId)
        .orderBy('title')
        .snapshots();
  }

  Future<Map<String, dynamic>> deleteEvent(String? eventId) async {
    try {
      List<Task>? eventTasks =
          await _taskServices.fetchTasksListByEvent(eventId);

      if (eventTasks.isNotEmpty) {
        for (Task task in eventTasks) {
          await _taskServices.deleteTask(task.id);
        }
      }

      await _collectionRef.doc(eventId).delete();

      return {
        'success': true,
        'message': 'Event deleted',
      };
    } catch (e) {
      return {'success': false, 'message': 'Error deleting event: $e'};
    }
  }
}
