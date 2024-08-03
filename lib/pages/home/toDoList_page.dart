// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/app_user.dart';
import 'package:event_planner/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../services/task_services.dart'; // Certifique-se de ajustar o caminho conforme necessário

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {

  final TextEditingController _textController = TextEditingController();
  late AppUser? _appUser;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {

    return Consumer2<TaskServices, UserServices>(
      builder: (context, taskServices, userServices, child) {
        return Scaffold(

          appBar: AppBar(title: const Text('To-Do List'),),
          body: StreamBuilder(

            stream: taskServices.fetchTasks(userServices.appUser),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _appUser = userServices.appUser;
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {DocumentSnapshot ds = snapshot.data!.docs[index];

                    return ListTile(
                      title: Text(
                        ds["description"],
                        style: TextStyle(decoration: ds["isDone"] ? TextDecoration.lineThrough : null,),
                      ),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {setState(() {taskServices.deleteTask2(index);});
                        },
                      ),

                      onTap: () {setState(() {taskServices.toggleDone2(index);});
                      },
                    );
                  },
                );
              }

              else
              {
                _appUser = userServices.appUser;
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {

                  return AlertDialog(
                    titlePadding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Task'),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {Navigator.of(context).pop();},
                        ),
                      ],
                    ),

                    content: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(labelText: 'Task',),
                    ),

                    actions: <Widget>[
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {

                            Task newTask = Task(description: _textController.text);
                            taskServices.addTask2(_appUser?.id, newTask);
                            _textController.clear();
                            
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

}