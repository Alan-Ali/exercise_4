import "package:flutter/material.dart";
import "./float.dart";
// import "./body.dart";
import "./bar.dart";
import "../../models/log.dart";
import "../../dependencies.dart";
import "../../services/task_service.dart";
import "../../services/todo_service.dart";
import "../../models/user.dart";
import "../../screens/login/login_screen.dart";


class MainScreen extends StatefulWidget{
    User? data;
    MainScreen({required this.data});

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>{
    get restTodo => service<TodoDataService>();
    get todoList => restTodo.getUserTodoList(widget.data!.userId);

    void navigateEdit(int index) async {
        dynamic response = Navigator.of(context).push(
          MaterialPageRoute(
            builder: ,
          ),
        )
    }
    @override
    Widget build(BuildContext context) {
      return FutureBuilder<>
    }
}


