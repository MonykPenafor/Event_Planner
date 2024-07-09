import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';

class UserServices extends ChangeNotifier {

  // for managing user authentication and data storage operations.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AppUser? appUser = AppUser();

  CollectionReference get _collectionRef => _firestore.collection(
      "users"); // Provides a reference to the 'users' collection in Firebase.

  DocumentReference get _docRef => _firestore.doc(
      'users/${appUser!.id}'); // Provides a reference to a specific user document using the user's ID.

  UserServices() {
    _loadCurrentUser();
  }

  Future<Map<String, dynamic>> signUp(
      String userName, String email, String password) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      appUser!.id = user!.uid;
      appUser!.email = user.email;
      appUser!.userName = userName;

      await saveData();

      return {'success': true, 'message': 'User created successfully'};
    } on FirebaseAuthException catch (error) {
      String message;
      if (error.code == 'invalid-email') {
        message = 'Invalid Email';
      } else if (error.code == 'weak-password') {
        message = 'The password is too weak, it must have a least 6 characters';
      } else if (error.code == 'email-already-in-use') {
        message = 'This email is registered already';
      } else {
        message = 'Error: ${error.message}';
      }

      return {
        'success': false,
        'message': message,
      };
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return {'success': true, 'message': 'User Logged'};
    } on FirebaseAuthException catch (error) {
      String message;
      if (error.code == 'invalid-email') {
        message = 'Invalid Email';
      } else if (error.code == 'wrong-password') {
        message = 'Wrong Password';
      } else if (error.code == 'user-disabled') {
        message = 'This user is disabled';
      } else {
        message = 'Error: ${error.message}';
      }
      return {
        'success': false,
        'message': message,
      };
    }
  }

  //save user data into firebase cloud firestore
  Future<void> saveData() async {
    await _docRef.set(appUser!.toJson());
  }

   _loadCurrentUser({User? user}) async {
    User? currentUser = user ?? _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot docUser =
          await _firestore.collection('users').doc(currentUser!.uid).get();
      appUser = AppUser.fromJson(docUser);
      notifyListeners();
    } else {
      appUser = AppUser(
          email: 'hey@gmail.com', id: currentUser!.uid, userName: 'hey');
    }
  }
}
