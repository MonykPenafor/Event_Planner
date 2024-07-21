import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../models/task.dart';

class TaskServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _collectionRef => _firestore.collection("tasks");

  List<Task> tasks = [];
  List<Task> allTasks = [];

  Future<Map<String, dynamic>> createTask(String userId, Task task1, {String eventId = "General Task (No event specifically)"}) async {
    try {
      Task task = Task(
        eventId: eventId,
        userId: userId,
        description: task1.description,
        isDone: task1.isDone,
      );

      // Add the task and get the document reference
      DocumentReference docRef = await _collectionRef.add(task.toJson());

      // Set the task ID
      task.id = docRef.id;

      // Optionally, update the document with the ID
      await _collectionRef.doc(task.id).set(task.toJson(), SetOptions(merge: true));
      notifyListeners();

      return {
        'success': true,
        'message': 'Task created successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error creating task: $e',
      };
    }
  }

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void toggleDone(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    notifyListeners();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }

  void resetTasks(){
    tasks = [];
  }



  void addTask2(String? userId, Task task) {
    createTask(userId!, task);
    allTasks.add(task);
    notifyListeners();
  }

  void toggleDone2(int index) {
    allTasks[index].isDone = !allTasks[index].isDone;
    notifyListeners();
  }

  void deleteTask2(int index) {
    allTasks.removeAt(index);
    notifyListeners();
  }


  void resetAllTasks(){
    allTasks = [];
  }

  

  Stream<QuerySnapshot> fetchTasks(AppUser? user) {

    String? id = user!.id;

    Stream<QuerySnapshot> taskStream = _collectionRef
          .where('userId', isEqualTo: id)
          .orderBy('description')
          .snapshots();

    taskStream.listen((QuerySnapshot snapshot) {
      allTasks = snapshot.docs.map((DocumentSnapshot document) {return Task.fromDocument(document);}).toList();
      notifyListeners();
    });

    return taskStream;
  }

}




