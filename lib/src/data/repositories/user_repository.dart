import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/user.dart';

class UserRepository {
  static const String _url = 'https://koreanjson.com';
  final http.Client client = http.Client();

  Future<List<User>> fetchUsers() async {
    final response = await client.get(Uri.parse('$_url/users'));

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

    final response = await client.post(Uri.parse('$_url/users'), body: body);

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }

    return User.fromJson(jsonDecode(response.body));
  }

  Future<User> fetchUser(int id) async {
    final Response response = await client.get(Uri.parse('$_url/users/$id'));
    return User.fromJson(jsonDecode(response.body));
  }

  Future<User> updateUser(int id, User user) async {
    Map<String, dynamic> body = user.toJson();
    final response = await client.put(Uri.parse('$_url/users/$id'), body: body);
    User updatedUser = User.fromJson(jsonDecode(response.body));
    return updatedUser;
  }

  Future<http.Response> deleteUser(int id) async {
    return client.delete(Uri.parse('$_url/users/$id'));
  }
}
