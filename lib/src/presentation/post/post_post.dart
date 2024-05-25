import 'package:flutter/material.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("한국어 Json 포스트 작성"),
      ),
      body: const Center(
        child: Text("포스트 작성 페이지"),
      ),
    );
  }
}
