import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../models/task.dart';

class TaskServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _collectionRef => _firestore.collection("tasks");

  List<Task> localTasks = [];
  late Stream<List<Task>> persistedTasks;
  
// LOCAL CHANGES
  void addLocalTask(Task task) {
     localTasks.add(task);
    notifyListeners();
  }

  void removeLocalTask(int index) {
    localTasks.removeAt(index);
    notifyListeners();
  }

  void toggleTaskDone(int index) {
    localTasks[index].isDone = !localTasks[index].isDone;
    notifyListeners();
  }

  void resetLocalTasks(){
    localTasks = [];
  }



// PERSISTED CHANGES

  Future<Map<String, dynamic>> createTask(String? userId, Task t, {String eventId = "General Task"}) async {
    try {
      Task task = Task(
        eventId: eventId,
        userId: userId,
        description: t.description,
        isDone: t.isDone,
      );

      DocumentReference docRef = await _collectionRef.add(task.toJson());

      task.id = docRef.id;

      await _collectionRef.doc(task.id).set(task.toJson(), SetOptions(merge: true));
      notifyListeners();

      return {
        'success': true,
        'message': 'Task created successfully',
      };
    } 
    catch (e) 
    {
      return {
        'success': false,
        'message': 'Error creating task: $e',
      };
    }
  }

  Stream<QuerySnapshot> fetchTasks(AppUser? user) {
    String? id = user!.id;
    return _collectionRef.where('userId', isEqualTo: id).orderBy('description').snapshots();
  }

  Future<void> deleteTask(String? taskId) async {
    await _collectionRef.doc(taskId).delete();
  }

  Future<void> toggleDone(String? taskId) async {
    DocumentSnapshot docSnapshot = await _collectionRef.doc(taskId).get();
    await _collectionRef.doc(taskId).update({'isDone': !docSnapshot.get('isDone'),}); 
  }

  Future<List<Task>> fetchTasksListByEvent(String? eventId) async {
    
    QuerySnapshot snapshot = await _collectionRef
        .where("eventId", isEqualTo: eventId)
        .get();

    List<Task> eventTasks = snapshot.docs.map((DocumentSnapshot document) {
      return Task.fromDocument(document);
    }).toList();

    return eventTasks;
  }

  Stream<List<Task>> fetchTasksStreamByEvent(String? eventId) async* {
    Stream<QuerySnapshot> taskStream = _collectionRef
        .where("eventId", isEqualTo: eventId)
        .snapshots();

    await for (QuerySnapshot snapshot in taskStream) {
      List<Task> tasks = snapshot.docs.map((DocumentSnapshot document) {
        return Task.fromDocument(document);
      }).toList();
      yield tasks;
    }
  }




}