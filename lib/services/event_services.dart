import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/app_user.dart';
import 'package:flutter/foundation.dart';
import '../models/event.dart';

class EventServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;   

  CollectionReference get _collectionRef => _firestore.collection("events"); 

  Future<Map<String, dynamic>> createEvent(String title, String userId, int numberOfGuests) async {
    try {
      Event event = Event(
        title: title,
        userId: userId,
        numberOfGuests: numberOfGuests,
      );

      await addEvent(event);

      return {
        'success': true,
        'message': 'Event created successfully'
      }; 
    } 
    catch (e) {
      return {
        'success': false,
        'message': 'Error creating event: $e'
      };
    }
  }

  Future<void> addEvent(Event event) async {
    await _collectionRef.add(event.toJson());
  }

  Stream<QuerySnapshot> fetchEvents(AppUser? user) {

  String? id = user!.id;

    return _collectionRef
        .where('userId', isEqualTo: id)
        .orderBy('title')
        .snapshots();
  }
}
