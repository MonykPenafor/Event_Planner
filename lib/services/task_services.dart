import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../models/task.dart';

class TaskServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _collectionRef => _firestore.collection("tasks");

  List<Task> tasks = [];
  List<Task> allTasks = [];

  List<Task> persistedTasks = [];
  List<Task> localTasks = [];

  Future<Map<String, dynamic>> createTask(String userId, Task t, {String eventId = "General Task"}) async {
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

  Stream<QuerySnapshot> fetchSpecificsTasksAsStream(String? eventId) {


    Stream<QuerySnapshot> taskStream = _collectionRef
          .where("eventId", isEqualTo: eventId)
          .orderBy('description')
          .snapshots();

    taskStream.listen((QuerySnapshot snapshot) {
      allTasks = snapshot.docs.map(
        (DocumentSnapshot document){return Task.fromDocument(document);}).toList();
        notifyListeners();
    });

    return taskStream;
  }


  List<Task>? fetchSpecificsTasksAsList(String? eventId) {

    List<Task>? eventTasks;

    Stream<QuerySnapshot> taskStream = _collectionRef
          .where("eventId", isEqualTo: eventId)
          .orderBy('description')
          .snapshots();

    taskStream.listen((QuerySnapshot snapshot) {
      eventTasks = snapshot.docs.map((DocumentSnapshot document) {return Task.fromDocument(document);}).toList();
      notifyListeners();
    });

    return eventTasks;
  }

  Future<void> deleteTask3(String? taskId) async {
    await _collectionRef.doc(taskId).delete();
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

  

}




