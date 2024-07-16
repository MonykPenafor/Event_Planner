// event DTO


import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Event(
      id: doc.id,
      title: doc['title'], 
      userId: doc['userId'], 
      numberOfAttendees: doc['numberOfAttendees'],
      imageUrl: doc['imageUrl'],
      date: doc['date'],
      location: doc['location'],
      theme: doc['theme'],
      description: doc['description'],
      type: doc['type'],
      sizeRating: doc['sizeRating'],
    );
  }



  Map<String, dynamic> toJson(){ 
    return {
      "id": id,
      "title": title,
      "userId": userId,
      "numberOfAttendees": numberOfAttendees,
      "imageUrl": imageUrl,
      "date": date,
      "location": location,
      "theme": theme,
      "description": description,
      "type": type,
      "sizeRating": sizeRating,
    };
  }
}



