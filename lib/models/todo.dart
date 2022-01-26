class Todo{
  int id, userIdd;
  String title, body;
  bool completed;

  Todo(this.id, {required this.userIdd,
   required this.title, required this.body, required this.completed});
  Todo.fromJson(Map<String, dynamic> json) 
  :this(
    json['id'],
    userIdd: json['userIdd'],
    title: json['title'],
    body: json['body'],
    completed: json['completed']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'userIdd': userIdd,
    'title': title,
    'body': body,
    'completed': completed
  };

}