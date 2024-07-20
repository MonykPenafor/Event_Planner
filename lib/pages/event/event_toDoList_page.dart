import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../services/task_services.dart';
import '../../services/user_services.dart';



class EventToDoListPage extends StatefulWidget {
  const EventToDoListPage({Key? key}) : super(key: key);

  @override
  _EventToDoListPage createState() => _EventToDoListPage();
}

class _EventToDoListPage extends State<EventToDoListPage> {

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskServices>(
      builder: (context, taskServices, child) {
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
                          Task newTask = Task(description: _textController.text);
                          taskServices.addTask(newTask); 
                        });
                        _textController.clear();
                      }                    
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: taskServices.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskServices.tasks[index];
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
                        setState(() {
                          taskServices.deleteTask(index);
                        });}
                    ),
                    onTap: (){
                      setState(() {
                        taskServices.toggleDone(index);
                      });
                    }
                  );
                },
              ),
            ),
          ],
        ),
      );
  });
  }


  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}