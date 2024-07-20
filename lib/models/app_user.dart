// user DTO

import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{

  String? id;
  String? userName;
  String? email;
  String? password;
  // String? phone;
  // String? role;
  
  AppUser({
    this.id, 
    this.userName, 
    this.email, 
    this.password, 
    // this.phone,
    // this.role,
  });

  Map<String, dynamic> toJson(){ 
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "password": password,
      // "phone": phone,
      // "role": role,
    };
  }

  AppUser.fromJson(DocumentSnapshot doc){
    id = doc.id;
    userName = doc.get('userName');
    email = doc.get('email');
  }




}