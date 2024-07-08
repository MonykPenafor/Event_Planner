// event DTO


import 'package:cloud_firestore/cloud_firestore.dart';

class Event{

  String? id;
  String? title;
  String? userId;
  
  Event({
    this.id, 
    this.title, 
    this.userId, 
  });



  // Factory method to create an Event from a Firestore DocumentSnapshot
  factory Event.fromDocument(DocumentSnapshot doc) {
    return Event(
      id: doc.id, // Document ID
      title: doc['title'], // 'title' field in the document
      userId: doc['userId'], // 'userId' field in the document
    );
  }



  Map<String, dynamic> toJson(){ 
    return {
      "id": id,
      "title": title,
      "userId": userId,
    };
  }
}



// class Event {
//   final String id;
//   final String title;
//   final String imageUrl;
//   final DateTime date;
//   final String location;
//   final int numberOfAttendees;
//   final String theme;
//   final String description;
//   final String type;
//   final String sizeRating;
//   final String inCharge;  // Username or User ID

//   Event({
//     required this.id,
//     required this.title,
//     required this.imageUrl,
//     required this.date,
//     required this.location,
//     required this.numberOfAttendees,
//     required this.theme,
//     required this.description,
//     required this.type,
//     required this.sizeRating,
//     required this.inCharge,
//   });