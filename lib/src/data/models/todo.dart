class Todo {
  final int id;
  final String title;
  final bool completed;
  final String createdAt;
  final String updatedAt;
  final int userId;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userId: json['UserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'UserId': userId,
    };
  }
}
