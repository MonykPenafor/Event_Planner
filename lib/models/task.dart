import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String description;
  bool isDone;
  String? eventId;

  Task({
    this.id,
    required this.description,
    this.isDone = false,
    this.eventId,
  });

  // Factory method to create a Task from a map
  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'],
      description: data['description'],
      isDone: data['isDone'],
      eventId: data['eventId'],
    );
  }

  // Method to convert a Task object to a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isDone': isDone,
      'eventId': eventId,
    };
  }


  factory Task.fromDocument(DocumentSnapshot doc) {
    return Task(
      id: doc.id,
      eventId: doc['eventId'],
      description: doc['description'],
      isDone: doc['isDone'],
    );
  }

}
