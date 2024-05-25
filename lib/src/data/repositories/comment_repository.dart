import 'dart:convert';

import 'package:flutter_application_1/src/config/constant.dart';
import 'package:flutter_application_1/src/data/models/comment.dart';
import 'package:http/http.dart' as http;

// /comments	GET	댓글 목록
// /comments?userId={id}	GET	유저별 댓글 목록
// /comments?postId={id}	GET	포스트별 댓글 목록
// /comments/:id	GET	댓글 조회
// /comments/:id	PUT	댓글 수정
// /comments/:id	DELETE	댓글 삭제
class CommentRepository {
  final http.Client client = http.Client();

  Future<List<Comment>> fetchPostsComments(int postId) async {
    /// Post별 댓글 목록을 가져온다. ///
    final response =
        await client.get(Uri.parse('$BASE_URL/comments?postId=$postId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load comments');
    }

    List<dynamic> json = jsonDecode(response.body);
    List<Comment> comments = [];

    for (var item in json) {
      comments.add(Comment.fromJson(item));
    }

    return comments;
  }
}
