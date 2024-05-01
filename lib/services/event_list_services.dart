import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';



class EventListServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addEvent(Event event) {
    _firestore.collection('events').add(event.toJson());
  }

}