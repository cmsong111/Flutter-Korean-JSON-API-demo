import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/models/comment.dart';
import 'package:flutter_application_1/src/data/models/post.dart';
import 'package:flutter_application_1/src/data/models/user.dart';
import 'package:flutter_application_1/src/data/repositories/comment_repository.dart';
import 'package:flutter_application_1/src/data/repositories/post_repository.dart';
import 'package:flutter_application_1/src/data/repositories/user_repository.dart';
import 'package:intl/intl.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  TextEditingController commentController = TextEditingController();

  late Future<Post> post;
  late Future<List<Comment>> comments;
  late Future<User> author;

  PostRepository postRepository = PostRepository();
  CommentRepository commentRepository = CommentRepository();
  UserRepository userRepository = UserRepository();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int postId = ModalRoute.of(context)!.settings.arguments as int;
    post = postRepository.fetchPost(postId);
    comments = commentRepository.fetchPostsComments(postId);
    author = post.then((post) => userRepository.fetchUser(post.userId));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        post,
        author,
        comments,
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Post post = snapshot.data![0] as Post;
          User author = snapshot.data![1] as User;
          List<Comment> comments = snapshot.data![2] as List<Comment>;
          return Scaffold(
            appBar: AppBar(
              title: const Text("포스트 상세 정보"),
            ),
            body: ListView(
              children: [
                ListTile(
                  title: Text(post.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(author.name),
                  subtitle: Text(author.email),
                ),
                ListTile(
                  title: Text(post.content),
                ),
                ListTile(
                  subtitle: Text(
                      "작성일: ${DateFormat("yyyy-MM-dd HH:mm:ss").format(post.createdAt)}"),
                ),
                const Divider(
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "댓글",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("  (${comments.length}개)")
                    ],
                  ),
                ),
                ListTile(
                  title: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    controller: commentController,
                    decoration: const InputDecoration(
                      hintText: "댓글을 입력하세요",
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    Comment comment = comments[index];
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(comment.content),
                      subtitle: Text(
                          "작성일: ${DateFormat("yyyy-MM-dd HH:mm:ss").format(comment.createdAt)}"),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
