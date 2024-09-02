import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/payment.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';

class PaymentServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _collectionRef => _firestore.collection("payments");

  List<Payment> localPayments = [];
  List<Payment> paymentsToDelete = [];
  double? budget;
  double? serviceFee;

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
    if(budget != null && budget != 0){
      return budget! - h;
    }
    return 0;
  }

  
// LOCAL CHANGES - EVENT PAGE
  void addLocalPayment(Payment payment) {
     localPayments.add(payment);
    notifyListeners();
  }

  void removeLocalPayment(int index) {
    localPayments.removeAt(index);
    notifyListeners();
  }

  void resetLocalPayments(){
    localPayments = [];
    paymentsToDelete = [];
  }




  Future<Map<String, dynamic>> createPayment(String? userId, Payment p, String eventId) async {
    try {
      Payment payment = Payment(
        eventId: eventId,
        userId: userId,
        description: p.description,
        category: p.category,
        value: p.value,
        img: p.img
      );

      DocumentReference docRef = await _collectionRef.add(payment.toJson());

      payment.id = docRef.id;

      await _collectionRef.doc(payment.id).set(payment.toJson(), SetOptions(merge: true));
      notifyListeners();

      return {
        'success': true,
        'message': 'Payment created successfully',
      };
    } 
    catch (e) 
    {
      return {
        'success': false,
        'message': 'Error creating Payment: $e',
      };
    }
  }

  Future<String> updatePayment(String? userId, Payment payment) async {
      await _collectionRef.doc(payment.id).set(payment.toJson(), SetOptions(merge: true));
      return "Event updated successfully";
  }

  Stream<QuerySnapshot> fetchPayments(AppUser? user) {
    String? id = user!.id;
    return _collectionRef.where('userId', isEqualTo: id).orderBy('description').snapshots();
  }

  Future<void> deletePayment(String? paymentId) async {
    await _collectionRef.doc(paymentId).delete();
  }

  Future<List<Payment>> fetchPaymentListByEvent(String? eventId) async {
    
    QuerySnapshot snapshot = await _collectionRef
        .where("eventId", isEqualTo: eventId)
        .get();

    List<Payment> eventPayments = snapshot.docs.map((DocumentSnapshot document) {
      return Payment.fromDocument(document);
    }).toList();

    return eventPayments;
  }

  Future<void> setPaymentsByEvent(String? eventId) async {
  final snapshot = await _collectionRef.where('eventId', isEqualTo: eventId).get();
  localPayments = snapshot.docs.map((doc) => Payment.fromDocument(doc)).toList();
  }

  fetchEventPayments(String? currentEventId){
    setPaymentsByEvent(currentEventId);
  }







}