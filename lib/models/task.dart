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
    this.eventId,
    this.userId,
  });

  // Convert Task object to map (JSON-compatible)
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
        description: doc.get('description'),
        isDone: doc.get('isDone'),
        eventId: doc.get('eventId'),
        userId: doc.get('userId'),
      );
    }

}