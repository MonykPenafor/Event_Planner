import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/app_user.dart';
import 'package:event_planner/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../services/task_services.dart';

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
          appBar: AppBar(
            title: const Text('To-Do List'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: taskServices.fetchTasks(userServices.appUser),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _appUser = userServices.appUser;

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    Task task = Task.fromDocument(doc);

                    return ListTile(
                      title: Text(
                        task.description,
                        style: TextStyle(
                          decoration:
                              task.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          taskServices.deleteTask(task.id);
                        },
                      ),
                      onTap: () {
                        taskServices.toggleDone(task.id);
                      },
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Task'),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    content: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        labelText: 'Task',
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {
                            Task newTask =
                                Task(description: _textController.text);
                            taskServices.createTask(_appUser!.id, newTask);
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
