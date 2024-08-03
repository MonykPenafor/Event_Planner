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
  String? userId;  

  Event(
    {
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


  // Convert an Event object to map (JSON-compatible)
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



  Event.fromDocument(DocumentSnapshot doc){
    
    DateTime? eventDate;

      try {
        eventDate = (doc.get("date") as Timestamp).toDate();
      } catch (e) {
        eventDate = null;
      }

    id = doc.id;
    title = doc.get('title');
    userId = doc.get('userId');
    numberOfAttendees = doc.get('numberOfAttendees');
    imageUrl = doc.get('imageUrl');
    date = eventDate;
    location = doc.get('location');
    theme = doc.get('theme');
    description = doc.get('description');
    type = doc.get('type');
    sizeRating = doc.get('sizeRating');
  }


}
