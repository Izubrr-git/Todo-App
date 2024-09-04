import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/todo.dart';

class TaskApiService {
  final String baseUrl = 'http://localhost:8080/api';

  Future<List<ToDo>> getTaskList() async {
    final url = Uri.parse('$baseUrl/todos');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> todoJsonList = json.decode(response.body);
        return todoJsonList.map((json) => ToDo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tasks. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  void addTask(String taskText) async {
    // Создание JSON тела запроса
    final Map<String, dynamic> requestBody = {
      'taskText': taskText,
      'isDone': false,
    };

    final url = Uri.parse('$baseUrl/todos');

    // Выполнение POST-запроса
    try {
      // Выполнение POST-запроса
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        // Успешное создание задачи
        print('Task added successfully!');
      } else {
        // Ошибка при создании задачи (например, сервер вернул ошибку 4xx или 5xx)
        print('Failed to add task. Error: ${response.body}');
      }
    } catch (e) {
      // Обработка исключений (например, если URL недоступен)
      print('Failed to connect to the server. Error: $e');
    }
  }

  Future<bool> deleteTask(String taskId) async {
    final url = Uri.parse('$baseUrl/todos/$taskId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete task. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  Future<ToDo> updateTask(ToDo todo) async {
    final url = Uri.parse('$baseUrl/todos/${todo.id}');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );
      if (response.statusCode == 200) {
        return ToDo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update task. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }
}