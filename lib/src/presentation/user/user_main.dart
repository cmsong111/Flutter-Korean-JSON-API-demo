import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/models/user.dart';
import 'package:flutter_application_1/src/data/repositories/user_repository.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late Future<List<User>> users;
  UserRepository userRepository = UserRepository();

  void refresh() {
    setState(() {
      users = userRepository.fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    users = userRepository.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("한국어 Json 유저 목록"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refresh,
          ),
        ],
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
                  onTap: () {},
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
