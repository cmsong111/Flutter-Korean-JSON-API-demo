import 'package:flutter_application_1/src/presentation/home_page.dart';
import 'package:flutter_application_1/src/presentation/post/post_detail.dart';
import 'package:flutter_application_1/src/presentation/post/post_post.dart';

class RouteName {
  static const home = '/';

  // Post
  static const post = '/post';
  static const postCreate = '/create';
}

var nameRoutes = {
  RouteName.home: (context) => const MyHomePage(),

  // Post Detail need int id
  RouteName.post: (context) => const PostDetailPage(),
  RouteName.postCreate: (context) => const PostCreatePage(),
};
