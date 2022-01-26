import "package:flutter/material.dart";
import "./float.dart";
import "./body.dart";
import "./bar.dart";
import "../../dependencies.dart";
import "../../services/todo_service.dart";
import "../../models/user.dart";
import "../../models/todo.dart";
import "dart:async";

StreamController<MainScreenState> streamController = StreamController<MainScreenState>();


class MainScreen extends StatefulWidget {
    User? user;
    List<User>? users;
    final MainScreenState _state;
    MainScreen({required this.user, required this.users, state}) : _state =state;

  @override
  MainScreenState createState() => MainScreenState();

 
}

class MainScreenState extends State<MainScreen>{
    get restTodo => service<TodoDataService>()!;
    // get userTask => service<TaskDataService>();
    get todoList => restTodo.getUserTodoList(widget.user!.userIdd);
    get todos => restTodo.getTodoList();
    List<Todo>? list;
    int? length;
    


    @override
    Widget build(BuildContext context) {
          return FutureBuilder<List<Todo>>(
            future: todoList,
            builder: (context, snapShot) {
              if(snapShot.connectionState == ConnectionState.done){
                if(snapShot.hasData){
                       list = snapShot.data!;
                        return Scaffold(
                          appBar: Bar(user: widget.user!, users: widget.users!),
                          // appBar: AppBar()
                          body: Body(list: list!, user: widget.user!),
                          floatingActionButton: _buildFloats(),
                        );
                }else if(snapShot.hasError){
                     return _buildFetchingDataScreen();
                }
           
              }
              return  _buildFetchingDataScreen() ;
            }
          );

    }

    FutureBuilder<List<Todo>> _buildFloats(){
      return FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapShot) {
          if(snapShot.hasData){
              length = snapShot.data!.length;
              return Float(todoLength: length, user: widget.user!);

          }
          throw "error";
        }
      );
    }

        Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching todo... Please wait'),
          ],
        ),
      ),
    );
  }
}
