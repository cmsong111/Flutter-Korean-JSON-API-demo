import 'package:flutter/material.dart';
import 'package:flutter_application_1/user-api.dart';
import 'package:flutter_application_1/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("한국어 Json 유저 목록"),
      ),
      body: FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          // 유저 데이터(Future) 로드 완료 시
          if (snapshot.hasData) {
            // 리스트 빌더를 통한 리스트 뷰 생성
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          }
          // 유저 데이터(Future) 로드 중
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
