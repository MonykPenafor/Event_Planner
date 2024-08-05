import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../services/task_services.dart';

class EventToDoListPage extends StatefulWidget {
  final Stream<List<Task>>? tasks;

  const EventToDoListPage({super.key, this.tasks});

  @override
  _EventToDoListPageState createState() => _EventToDoListPageState();
}

class _EventToDoListPageState extends State<EventToDoListPage> {
  final TextEditingController _textController = TextEditingController();
  List<Task> localTasks = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskServices>(builder: (context, taskServices, child) {
      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Add a task',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        setState(() {
                          Task task = Task(description: _textController.text);
                          localTasks.add(task);
                        });
                        _textController.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Task>>(
                stream: widget.tasks,
                builder: (context, snapshot) {
                  List<Task> tasks = [];
                  if (snapshot.hasData) {
                    tasks = snapshot.data!;
                  }
                  tasks.addAll(localTasks);

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        title: Text(
                          task.description,
                          style: TextStyle(
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              if (index < tasks.length - localTasks.length) {
                                // Se for uma tarefa do banco de dados, remova do banco
                                taskServices.deleteTask(task.id);
                              } else {
                                // Se for uma tarefa local, remova da lista local
                                localTasks.removeAt(index -
                                    (tasks.length - localTasks.length));
                              }
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            task.isDone = !task.isDone;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
