import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/models/post.dart';
import 'package:flutter_application_1/src/data/repositories/post_repository.dart';

class PostHomePage extends StatefulWidget {
  const PostHomePage({super.key});

  @override
  State<PostHomePage> createState() => _PostHomePageState();
}

class _PostHomePageState extends State<PostHomePage> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    PostRepository postRepository = PostRepository();
    posts = postRepository.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("한국어 Json 포스트 목록"),
      ),
      body: FutureBuilder(
        future: posts,
        builder: (context, snapshot) {
          // Post 데이터(Future) 로드 완료 시
          if (snapshot.hasData) {
            // 리스트 빌더를 통한 리스트 뷰 생성
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Post post = snapshot.data![index];
                return ListTile(
                  title: Text(
                    post.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.content,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {},
                );
              },
            );
          }
          // Post 데이터(Future) 로드 중
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
