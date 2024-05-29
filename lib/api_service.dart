import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  static Future<List<dynamic>> getTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load todos');
    }
  }

  static Future<void> createTodo(String title) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(<String, dynamic>{'title': title, 'completed': false, 'userId': 1}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create todo');
    }
  }

  static Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }

  static Future<void> updateTodo(int id, String title) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      body: jsonEncode(<String, dynamic>{'title': title, 'completed': false, 'userId': 1}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }
}