//Aline benedicto soares - 201268

import 'package:flutter/material.dart';

void main() {
  runApp(TaskListApp());
}

class TaskListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
              title: Text('Lista de Tarefas'),
              backgroundColor: Color.fromARGB(181, 158, 0, 0),
        ),
        body: TaskList(),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();

  void _addTask() {
    String newTask = taskController.text;
    if (newTask.isNotEmpty) {
      setState(() {
        tasks.add(newTask);
        taskController.clear();
      });
    }
  }

  void _clearList() {
    setState(() {
      tasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: taskController,
            decoration: InputDecoration(
              labelText: 'Nova Tarefa',
             labelStyle: TextStyle(color: Color.fromARGB(181, 180, 0, 0)), 
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _addTask,
          style: ElevatedButton.styleFrom(
             backgroundColor:  Color.fromARGB(181, 58, 0, 0), // Background color
             ),
          child: Text('Adicionar'), 
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index]),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _clearList,
          style: ElevatedButton.styleFrom(
             backgroundColor:  Color.fromARGB(181, 58, 0, 0), // Background color
             ),
          child: Text('Limpar Lista'),
        ),
      ],
    );
  }
}
