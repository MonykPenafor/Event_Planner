// event DTO


class Event{

  String? id;
  String? title;
  String? date;
  String? inCharge;
  
  Event({
    this.id, 
    this.title, 
    this.date,
    this.inCharge, 
  });

  Map<String, dynamic> toJson(){ 
    return {
      "id": id,
      "Title": title,
      "email": date,
      "In Charge": inCharge,
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