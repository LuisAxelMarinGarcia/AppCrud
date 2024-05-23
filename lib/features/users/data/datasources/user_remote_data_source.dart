import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crud/features/users/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> createUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<UserModel> getUser(String id);
  Future<List<UserModel>> getAllUsers();
  Future<void> deleteUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createUser(UserModel user) async {
    final response = await client.post(
      Uri.parse('http://10.0.2.2:8080/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('User created successfully');
    } else {
      print('Failed to create user: ${response.statusCode}');
      throw Exception('Failed to create user');
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final response = await client.put(
      Uri.parse('http://10.0.2.2:8080/user/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      print('Failed to update user: ${response.statusCode}');
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8080/user/$id'),
    );
    if (response.statusCode == 200) {
      print('User retrieved successfully');
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to retrieve user: ${response.statusCode}');
      throw Exception('Failed to retrieve user');
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await client.get(
      Uri.parse('http://10.0.2.2:8080/user'),
    );
    if (response.statusCode == 200) {
      print('Users retrieved successfully');
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> usersJson = jsonResponse['data'];
      return usersJson.map((user) => UserModel.fromJson(user)).toList();
    } else {
      print('Failed to retrieve users: ${response.statusCode}');
      throw Exception('Failed to retrieve users');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    final response = await client.delete(
      Uri.parse('http://10.0.2.2:8080/user/$id'),
    );
    if (response.statusCode == 200) {
      print('User deleted successfully');
    } else {
      print('Failed to delete user: ${response.statusCode}');
      throw Exception('Failed to delete user');
    }
  }
}
