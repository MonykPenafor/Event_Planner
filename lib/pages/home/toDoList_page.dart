// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {

final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
              const Text('Digite algo'),
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
              labelText: 'Digite algo',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Enviar'),
              onPressed: () {
                print(_textController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );},
        child: const Icon(Icons.add),
      ),
    );
  }
}
