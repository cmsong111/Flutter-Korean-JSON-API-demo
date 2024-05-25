import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/models/todo.dart';
import 'package:flutter_application_1/src/data/repositories/todo_repository.dart';
import 'package:intl/intl.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  late Future<List<Todo>> todos;

  void sort() {
    setState(() {
      // 완료 여부, createdAt 기준으로 정렬
      todos = todos.then((todos) {
        todos.sort((a, b) {
          if (a.completed == b.completed) {
            return a.createdAt.compareTo(b.createdAt);
          } else {
            return a.completed ? 1 : -1;
          }
        });
        return todos;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    TodoRepository todoRepository = TodoRepository();
    todos = todoRepository.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("한국어 Json 할 일 목록"),
      ),
      body: FutureBuilder(
        future: todos,
        builder: (context, snapshot) {
          // 할 일 데이터(Future) 로드 완료 시
          if (snapshot.hasData) {
            // 리스트 빌더를 통한 리스트 뷰 생성
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data![index];
                return ListTile(
                    title: Text(
                      todo.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "생성일: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(todo.createdAt)}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {},
                    trailing: Switch(
                      value: todo.completed,
                      onChanged: (value) {
                        setState(() {
                          todo.completed = value;
                        });
                      },
                    ));
              },
            );
          }
          // 할 일 데이터(Future) 로드 중
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
