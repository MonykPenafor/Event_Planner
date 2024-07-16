// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/app_user.dart';
import 'package:flutter/foundation.dart';
import '../models/event.dart';

class EventServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;   

  CollectionReference get _collectionRef => _firestore.collection("events"); 

  Future<Map<String, dynamic>> createEvent({String? title, String? userId, int? numberOfAttendees, String? location, DateTime? date, String? theme, String? imageUrl, String? description, String? type,  String? sizeRating}) async {
    try {

      Event event = Event(
        title: title ?? null,
        userId: userId ?? null,
        numberOfAttendees: numberOfAttendees ?? 0, // Default to 0 if null
        location: location ?? null,
        date: date ?? null,
        theme: theme ?? null,
        imageUrl: imageUrl ?? null,
        description: description ?? null,
        type: type ?? null,
        sizeRating: sizeRating ?? null,
      );

      // Add the event and get the document reference
      DocumentReference docRef = await _collectionRef.add(event.toJson());

      // Set the event ID
      event.id = docRef.id;

      // Optionally, update the document with the ID
      await _collectionRef.doc(event.id).set(event.toJson(), SetOptions(merge: true));


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


  Stream<QuerySnapshot> fetchEvents(AppUser? user) {

  String? id = user!.id;

    return _collectionRef
        .where('userId', isEqualTo: id)
        .orderBy('title')
        .snapshots();
  }
}
