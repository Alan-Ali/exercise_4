import "dart:convert";
import "../models/todo.dart";
import "../dependencies.dart";
import "./rest_service.dart";
import "../models/user.dart";


class TodoDataService{
  final rest = service<RestService>();

  Future<List<Todo>> getTodoList() async {
    final response = await rest.get("todos");

    List<Todo> list = response.map((element) => Todo.fromJson(element)).toList();

    return list;
  }

  Future<List<Todo>> getUserTodoList(int userId) async {
      final todoList = await getTodoList();
      List<Todo> filteredTodo = todoList.where((element) => element.userId == userId).toList();
      
       return filteredTodo;
      
  }

  Future<Todo> updateTodoList(int id, Todo todo) async {
    final response =  await rest.patch("todos/$id", data: todo);

    return Todo.fromJson(response);
  }

  Future createTodo(Todo todo) async {
        await rest.post("todos", todo: todo);
  }

 


}
