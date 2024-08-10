import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task.dart';
import '../../services/task_services.dart';

class EventToDoListPage extends StatefulWidget {
  const EventToDoListPage({super.key});

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
              child: taskServices.localTasks.isEmpty
                  ? const Center(child: Text('No tasks available'))
                  : ListView.builder(
                      itemCount: taskServices.localTasks.length,
                      itemBuilder: (context, index) {
                        var task = taskServices.localTasks[index];
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
                              
                              taskServices.removeLocalTask(index);
                              if (task.id != null) {
                                  taskServices.tasksToDetele.add(task);
                              }
                            },
                          ),
                          onTap: () {
                              taskServices.toggleTaskDone(index);
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
