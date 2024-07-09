import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/event.dart';

class EventListServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;   

  CollectionReference get _collectionRef => _firestore.collection("events"); 

  Future<Map<String, dynamic>> createEvent(String title, String userId) async {
    try {
      Event event = Event(
        title: title,
        userId: userId,
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

  Stream<QuerySnapshot> getEvents(User? user) {

  String aa = user!.uid;

    return _firestore.collection('events')
        .where('userId', isEqualTo: aa)
        .orderBy('title')
        .snapshots();
  }
}
