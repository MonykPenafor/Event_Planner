
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';

class UserServices{

  // for managing user authentication and data storage operations.
  final FirebaseAuth _auth = FirebaseAuth.instance;           
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;   

  final AppUser? _appUser = AppUser(); 

  CollectionReference get _collectionRef => _firestore.collection("users");    // Provides a reference to the 'users' collection in Firebase.
  DocumentReference get _docRef => _firestore.doc('users/${_appUser!.id}');   // Provides a reference to a specific user document using the user's ID.


  signUp(String userName, String email, String password) async { 

    try {
      User? user = (await  _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password)).user;      

      _appUser!.id = user!.uid;
      _appUser.email = user.email;
      _appUser.userName = userName; 

      saveData();

      print('User created successfully'); 

    } 
    catch (e) 
    {
      print('Error creating user: $e'); // Adicionando um print para exibir o erro caso ocorra algum problema
    }
  }


  //save user data into firebase cloud firestore
  saveData() {
    _docRef.set(_appUser!.toJson());
  }


  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

    
}