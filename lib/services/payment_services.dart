import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../models/task.dart';

class PaymentServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _collectionRef => _firestore.collection("payments");

  List<Task> localPayments = [];
  List<Task> paymentsToDelete = [];
  double budget = 0.00;
  double serviceFee = 0.00;

  void updateBudget(double newBudget) {
    budget = newBudget;
    notifyListeners();
  }

  void updateServiceFee(double newServiceFee) {
    serviceFee = newServiceFee;
    notifyListeners();
  }

  double calculateSpent(){
    return 200;
  }
  double calculateMoneySpent(){
    return 210;
  }

  double calculateRemaining(){
    var h = calculateSpent();
    return budget - h;
  }

}