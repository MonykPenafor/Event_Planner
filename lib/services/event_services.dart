import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/app_user.dart';
import 'package:event_planner/services/payment_services.dart';
import 'package:event_planner/services/task_services.dart';
import 'package:flutter/foundation.dart';
import '../models/event.dart';
import '../models/payment.dart';
import '../models/task.dart';

class EventServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _collectionRef => _firestore.collection("events");

  final TaskServices _taskServices = TaskServices();
  final PaymentServices _paymentServices = PaymentServices();

  Future<Map<String, dynamic>> saveEvent(Event event, String? userId, List<Task> tasks, List<Task> tasksToDelete, List<Payment> payments, List<Payment> paymentsToDelete) async {
    
    dynamic result;

    try {
      if (event.id != null) 
      {
        result = await updateEvent(userId, event, tasks, tasksToDelete, payments, paymentsToDelete);
      } 
      else 
      {
        result = await createEvent(userId, event, tasks, payments);
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

  Future<String> createEvent(String? userId, Event event, List<Task>? tasks, List<Payment>? payments) async {
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

      if (payments != null) {
        for (var payment in payments) {
          await _paymentServices.createPayment(userId!, payment, docRef.id);
        }
      }

      return "Event created successfully";
  }

  Future<String> updateEvent(String? userId, Event event, List<Task>? tasks, List<Task>? tasksToDelete, List<Payment>? payments, List<Payment>? paymentsToDelete) async {

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

      if (tasksToDelete!.isNotEmpty) {
        for (Task task in tasksToDelete) {
          await _taskServices.deleteTask(task.id);
        }
      }

      if (payments != null) {
        for (var payment in payments) {
          if (payment.id != null) {
          _paymentServices.updatePayment(userId!, payment);
          }
          else{
          _paymentServices.createPayment(userId!, payment, event.id!);
          }
        }
      }

      if (payments!.isNotEmpty) {
        for (Payment payment in paymentsToDelete!) {
          await _paymentServices.deletePayment(payment.id);
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

      List<Payment>? eventPayments =
          await _paymentServices.fetchPaymentListByEvent(eventId);

      if (eventPayments.isNotEmpty) {
        for (Payment payment in eventPayments) {
          await _paymentServices.deletePayment(payment.id);
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


  Future<List<Event>> fetchEventsList(String? userId) async {
    QuerySnapshot snapshot = await _collectionRef.where('userId', isEqualTo: userId)
        .orderBy('title')
        .get();

    return snapshot.docs.map((doc) {
      return Event.fromDocument(doc);
    }).toList();
  }

}
