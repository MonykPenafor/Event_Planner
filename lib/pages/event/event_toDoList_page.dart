import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../services/task_services.dart';

class EventToDoListPage extends StatefulWidget {

  final Stream<List<Task>>? persistedTasks;

  const EventToDoListPage({super.key, this.persistedTasks});

  @override
  _EventToDoListPageState createState() => _EventToDoListPageState();
}

class _EventToDoListPageState extends State<EventToDoListPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskServices>(builder: (context, taskServices, child) {
      List<Task> tasks = taskServices.localTasks;

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
                        Task task = Task(description: _textController.text);
                        taskServices.addLocalTask(task);
                        _textController.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: tasks.isEmpty ? const Center(child: Text('No tasks available')) : 
                    ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return ListTile(
                          title: Text(
                            task.description,
                            style: TextStyle(
                              decoration: task.isDone ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              taskServices.removeLocalTask(index);
                            },
                          ),
                          onTap: () {
                            taskServices.toggleTaskDone(index);
                          },
                        );
                      },
                    ),
            ),
          
            if (widget.persistedTasks != null)
              Expanded(
                child: StreamBuilder<List<Task>>(
                  stream: widget.persistedTasks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading tasks'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No tasks available'));
                    } else {
                      List<Task> persistedTasks = snapshot.data!;
                      return ListView.builder(
                        itemCount: persistedTasks.length,
                        itemBuilder: (context, index) {
                          final task = persistedTasks[index];
                          return ListTile(
                            title: Text(
                              task.description,
                              style: TextStyle(
                                decoration: task.isDone ? TextDecoration.lineThrough : null,
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
                    }
                  },
                ),
              ),
          ],
        ),
      );
    });
  }
}