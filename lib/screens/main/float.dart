import 'package:exercise_4/models/todo.dart';
import 'package:exercise_4/models/user.dart';
import 'package:exercise_4/services/task_service.dart';
import 'package:exercise_4/services/todo_service.dart';
import "package:flutter/material.dart";
import "../../screens/main/main_screen.dart";
import "../edit/body.dart";
// import "dart:async";
import "../../dependencies.dart";
import "./main_screen.dart";

// StreamController<int> streamController = StreamController<int>();




class Float extends StatefulWidget{

    int? todoLength;
    User? user;
    Float({ required this.user, required this.todoLength});


  @override
  _FloatState createState() => _FloatState();
}


class _FloatState extends State<Float>{
  get restTask => service<TaskDataService>();
  get todoList => service<TodoDataService>();
  get todoLength => todoList.getTodoList();
  get usersList => restTask.getUsers();
  List<Todo>? todos;
  Todo? todo;
  late List<User> users;


void navigateToMain() async {
  await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FutureBuilder<List<User>>(
          future: usersList,
          builder: (context, snapShot) {
            switch (snapShot.connectionState) {  
              case ConnectionState.waiting:
                   return  _buildFetchingDataScreen();
              default:
                if (snapShot.hasData) {
                  users = snapShot.data!;
                  return MainScreen(user: widget.user, users: users); 
                } else {
                  
                  return _buildFetchingDataScreen();
                }
          
           }
          },
      ),
    ),
  );
}


FutureBuilder<List<Todo>> length() {
  return FutureBuilder<List<Todo>>(
        future: todoLength,
        builder: (context, snapShot) {
            if(snapShot.hasData){

              todos = snapShot.data!;
            
           return Text("added");

            }return const Text("error");
            // throw "error";
        }
      );
}



@override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
      FloatingActionButton(
        heroTag: null,
        onPressed:() {
            navigateToMain();
        },
        child:const Icon(Icons.refresh),
      ),
      FloatingActionButton(
        heroTag: null,
        onPressed:() async {
           length();
             todo = Todo(
                  widget.todoLength! + 1 * 2,
                  userIdd: widget.user!.userIdd,
                  title: "New Todo",
                  body: "ready to set",
                  completed: false);
              todoList.createTodo(todo);
           navigateToMain();
        } ,
        child:const Icon(Icons.add),
      ),
    ]
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

