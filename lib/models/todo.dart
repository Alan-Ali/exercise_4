class Todo{
  int id, userId;
  String title, body;
  bool completed;

  Todo(this.id, {required this.userId,
   required this.title, required this.body, required this.completed});
  Todo.fromJson(Map<String, dynamic> json) 
  :this(
    json['id'],
    userId: json['userId'],
    title: json['title'],
    body: json['body'],
    completed: json['completed']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body,
    'completed': completed
  };

}