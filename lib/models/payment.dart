import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  String? id;
  String description;
  double value;
  String? img;
  String? eventId;
  String? userId;

  Payment({
    this.id,
    required this.description,
    required this.value,
    this.img,
    this.eventId,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'value': value,
      'img': img,
      'eventId': eventId,
      'userId': userId,
    };
  }

  factory Payment.fromDocument(DocumentSnapshot doc) {
      return Payment(
        id: doc.id,
        description: doc.get('description'),
        value: doc.get('value'),
        img: doc.get('img'),
        eventId: doc.get('eventId'),
        userId: doc.get('userId'),
      );
    }

}