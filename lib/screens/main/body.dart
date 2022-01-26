import "package:flutter/material.dart";
import "../../models/todo.dart";
import "../../services/todo_service.dart";
import "../../dependencies.dart";
import "../../screens/edit/edit_screen.dart";
import "../../models/user.dart";
import "./float.dart";
import "./main_screen.dart";
import "dart:async";

class Body extends StatefulWidget {
  List<Todo>? list;
  User? user;
  final MainScreenState _state;
  // final Float({state})  = state;
  
  Body({required this.list, required this.user, state}) : _state = state;
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  // final restUser = ;
  get todoList => service<TodoDataService>()!;
  late Todo _todo;

  void navigateEditScreen(int? index) async {
    final response = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditScreen(todo: widget.list![index!]),
    ));
    if (response != null) {
      widget.list![index!] = response;
      setState(() => {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: todoList.getUserTodoList(widget.user!.userIdd),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List<Todo> todos = snapShot.data!;
          return ListView.separated(
              itemBuilder: (context, index) {
                _todo = todos[index];
                return ListTile(
                  title: Text(_todo.title),
                  subtitle: Text(_todo.body),
                  onTap: () => navigateEditScreen(index),
                  onLongPress: (){
                      todoList.deleteTodo(_todo.id);
                    setState(() {
                      widget.list!.length =widget.list!.length - 1; 
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                  ),
              itemCount: widget.list!.length);
        }
        return  _buildFetchingDataScreen();
      },
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
