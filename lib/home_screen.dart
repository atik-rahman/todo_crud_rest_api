import 'package:flutter/material.dart';

class CrudApi extends StatefulWidget {
  const CrudApi({super.key, required this.title});

  final String title;

  @override
  _CrudApiState createState() => _CrudApiState();
}

class _CrudApiState extends State<CrudApi> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _todos = [];
  int _nextId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter ToDo',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _createTodo();
            },
            child: const Text('Add ToDo'),
          ),
          Expanded(
            child: _todos.isEmpty
                ? const Center(child: Text('No todos yet.'))
                : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todos[index]['title']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editTodoDialog(index);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteTodo(_todos[index]['id']);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _createTodo() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _todos.add({'id': _nextId++, 'title': _controller.text});
    });
    _controller.clear();
  }

  void _deleteTodo(int id) {
    setState(() {
      _todos.removeWhere((todo) => todo['id'] == id);
    });
  }

  void _editTodoDialog(int index) {
    final TextEditingController _editController = TextEditingController(text: _todos[index]['title']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit ToDo'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(
              labelText: 'Edit ToDo',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _editTodo(index, _editController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editTodo(int index, String newTitle) {
    if (newTitle.isEmpty) return;
    setState(() {
      _todos[index]['title'] = newTitle;
    });
  }
}