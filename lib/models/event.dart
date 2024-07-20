import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/task.dart';

class Event {
  String? id;
  String? title;
  String? imageUrl;
  DateTime? date;
  String? location;
  int? numberOfAttendees;
  String? theme;
  String? description;
  String? type;
  String? sizeRating;
  String? userId;  // Username or User ID

  Event({
    this.id,
    this.title,
    this.imageUrl,
    this.date,
    this.location,
    this.numberOfAttendees,
    this.theme,
    this.description,
    this.type,
    this.sizeRating,
    this.userId,
  });

  // Factory method to create an Event from a Firestore DocumentSnapshot
  factory Event.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Event(
      id: doc.id,
      title: data['title'],
      userId: data['userId'],
      numberOfAttendees: data['numberOfAttendees'],
      imageUrl: data['imageUrl'],
      date: (data['date'] as Timestamp).toDate(),
      location: data['location'],
      theme: data['theme'],
      description: data['description'],
      type: data['type'],
      sizeRating: data['sizeRating'],
    );
  }

  // Method to convert an Event object to a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "userId": userId,
      "numberOfAttendees": numberOfAttendees,
      "imageUrl": imageUrl,
      "date": date != null ? Timestamp.fromDate(date!) : null,
      "location": location,
      "theme": theme,
      "description": description,
      "type": type,
      "sizeRating": sizeRating,
    };
  }
}
