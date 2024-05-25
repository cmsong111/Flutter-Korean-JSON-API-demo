import 'dart:convert';

import 'package:flutter_application_1/src/config/constant.dart';
import 'package:flutter_application_1/src/data/models/post.dart';
import 'package:http/http.dart' as http;

// /posts	GET	포스트 목록
// /posts?userId={id}	GET	유저별 포스트 목록
// /posts	POST	포스트 생성
// /posts/:id	GET	포스트 조회
// /posts/:id	PUT	포스트 수정
// /posts/:id	DELETE	포스트 삭제
class PostRepository {
  final http.Client client = http.Client();

  Future<List<Post>> fetchPosts() async {
    /// Post 목록을 가져온다. ///
    final response = await client.get(Uri.parse('$BASE_URL/posts'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }
    List<dynamic> json = jsonDecode(response.body);

    List<Post> posts = [];

    for (var item in json) {
      posts.add(Post.fromJson(item));
    }

    return posts;
  }

  Future<Post> fetchPost(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/posts/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load post');
    }

    return Post.fromJson(jsonDecode(response.body));
  }
}
