import 'dart:convert';

import 'package:flutter_application_1/src/config/constant.dart';
import 'package:flutter_application_1/src/data/models/todo.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// /todos	GET	할 일 목록
// /todos?userId={id}	GET	유저별 할 일 목록
// /todos	POST	할 일 생성
// /todos/:id	GET	할 일 조회
// /todos/:id	PUT	할 일 수정
// /todos/:id	DELETE	할 일 삭제
class TodoRepository {
  final http.Client client = http.Client();

  Future<List<Todo>> fetchTodos() async {
    /// 할 일 목록을 가져온다. ///
    final Response response = await client.get(Uri.parse('$BASE_URL/todos'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load todos');
    }

    List<dynamic> json = jsonDecode(response.body);
    List<Todo> todos = <Todo>[];

    for (var item in json) {
      todos.add(Todo.fromJson(item));
    }

    return todos;
  }
}
