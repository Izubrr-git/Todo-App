import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/urls.dart';
import '../model/user.dart';

class UserApiService {
  Future<User> getUserById(String userId) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  Future<User> updateUser(User user) async {
    final url = Uri.parse('$baseUrl/users/${user.id}');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update user. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  Future<bool> deleteUser(String userId) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete user. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  Future<User> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Login failed. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  Future<User> register(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Registration failed. Error: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }
}