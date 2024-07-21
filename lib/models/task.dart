import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String description;
  bool isDone;
  String? eventId;
  String? userId;

  Task({
    this.id,
    required this.description,
    this.isDone = false,
    this.eventId = "General Task (No event specifically)",
    this.userId,
  });

  // Factory method to create a Task from a map
  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'],
      description: data['description'],
      isDone: data['isDone'],
      eventId: data['eventId'],
      userId: data['userId'],
    );
  }

  // Method to convert a Task object to a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isDone': isDone,
      'eventId': eventId,
      'userId': userId,
    };
  }

  factory Task.fromDocument(DocumentSnapshot doc) {
    return Task(
      id: doc.id,
      eventId: doc['eventId'],
      description: doc['description'],
      isDone: doc['isDone'],
      userId: doc['userId'],
    );
  }

}