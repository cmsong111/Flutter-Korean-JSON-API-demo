import 'dart:convert';
import 'package:flutter_application_1/src/config/constant.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/user.dart';

class UserRepository {
  final http.Client client = http.Client();

  Future<List<User>> fetchUsers() async {
    final response = await client.get(Uri.parse('$BASE_URL/users'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load users');
    }

    List<dynamic> json = jsonDecode(response.body);
    List<User> users = [];

    for (var item in json) {
      users.add(User.fromJson(item));
    }

    return users;
  }

  Future<User> createUser({required User user}) async {
    Map<String, dynamic> body = user.toJson();

    final response =
        await client.post(Uri.parse('$BASE_URL/users'), body: body);

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }

    return User.fromJson(jsonDecode(response.body));
  }

  Future<User> fetchUser(int id) async {
    final Response response =
        await client.get(Uri.parse('$BASE_URL/users/$id'));
    return User.fromJson(jsonDecode(response.body));
  }

  Future<User> updateUser(int id, User user) async {
    Map<String, dynamic> body = user.toJson();
    final response =
        await client.put(Uri.parse('$BASE_URL/users/$id'), body: body);
    User updatedUser = User.fromJson(jsonDecode(response.body));
    return updatedUser;
  }

  Future<http.Response> deleteUser(int id) async {
    return client.delete(Uri.parse('$BASE_URL/users/$id'));
  }
}
