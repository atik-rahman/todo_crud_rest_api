import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App with REST API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CrudApi(title: 'ToDo App with REST API'),
    );
  }
}