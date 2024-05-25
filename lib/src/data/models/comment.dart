class Comment {
  final int id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final int postId;

  Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.postId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userId: json['UserId'],
      postId: json['PostId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'UserId': userId,
      'PostId': postId,
    };
  }
}
