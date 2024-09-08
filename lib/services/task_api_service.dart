import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/todo.dart';

class TaskApiService {
  final String baseUrl = 'http://localhost:8080/api';
  final String userId;

  TaskApiService(this.userId);

  Future<List<ToDo>> getTaskList() async {
    final url = Uri.parse('$baseUrl/users/$userId/todos');
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

  Future<bool> addTask(String taskText) async {
    final Map<String, dynamic> requestBody = {
      'taskText': taskText,
      'isDone': false,
    };

    final url = Uri.parse('$baseUrl/users/$userId/todos');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Task added successfully!');
        }
        return true;
      } else {
        throw Exception('Failed to add task. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  Future<bool> deleteTask(String taskId) async {
    final url = Uri.parse('$baseUrl/users/$userId/todos/$taskId');
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
    final url = Uri.parse('$baseUrl/users/$userId/todos/${todo.id}');
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