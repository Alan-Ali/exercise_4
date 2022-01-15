import "package:flutter/material.dart";
import "./float.dart";
import "./body.dart";
import "./bar.dart";
import "../../dependencies.dart";
import "../../services/todo_service.dart";
import "../../models/user.dart";
import "../../models/todo.dart";
// import "../../services/task_service.dart";

class MainScreen extends StatefulWidget {
    User? user;
    List<User>? users;
    MainScreen({Key? key,  required this.user, required users}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>{
    get restTodo => service<TodoDataService>();
    // get userTask => service<TaskDataService>();
    get todoList => restTodo.getUserTodoList(widget.user!.userId);
    List<Todo>? list;
    // void navigateEdit(int index) async {
    //     dynamic response = Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: ,
    //       ),
    //     )
    // }

 

    @override
    Widget build(BuildContext context) {
      return FutureBuilder<List<Todo>>(
        future: todoList,
        builder: (context, snapShot) {
            list = snapShot.data;
            return Scaffold(
              appBar: Bar(user: widget.user, users: widget.users),
              // appBar: AppBar()
              body: Body(list: list!),
              // floatingActionButton: Float(),
            );
        }
      );
    }
}


