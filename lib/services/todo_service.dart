import "dart:convert";
import "../models/todo.dart";
import "../dependencies.dart";
import "./rest_service.dart";


class TodoDataService{
  final rest = service<RestService>();

  Future<List<Todo>> getTodoList() async {
    final response = await rest.get("todo");

    List<Todo> list;

    return list = response.map((element) => Todo.fromJson(element)).toList();
  }

  Future<dynamic> getUserTodoList(int userId) async {
      final todoList = await getTodoList();
      dynamic filteredTodo = todoList.where((element) => element.userId == userId);
      
      if (filteredTodo) return filteredTodo;
      else return false;
  }

  Future<Todo> updateTodoList(int id, Todo todo) async {
    final response =  await rest.patch("todos/$id", data: todo);

    return Todo.fromJson(response);
  }

  Future createTodo(Todo todo) async {
        await rest.post("todos", todo: todo);
  }

 


}
