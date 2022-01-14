import 'package:flutter/material.dart';
import './screens/main/main_screen.dart';
import './dependencies.dart' as dep;
import "../../models/log.dart";
import "../../dependencies.dart";
import "../../services/task_service.dart";
import "../../services/todo_service.dart";
import "../../models/user.dart";
import "../../screens/login/login_screen.dart";

void main() {
  dep.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.green,
      ),
      home: Main(),
    );
  }
}





class Main extends StatefulWidget {

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  get restUser => service<TaskDataService>();
  get restTodo => service<TodoDataService>();
  get logs => restUser.userLogin();
  get userList => restUser.getUsers();

  Logs? json;
  List<User>? users;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Logs>(
      future: logs,
      builder: (context, snapShot) {
        json = snapShot.data;

        if (!json!.log) {
          return _buildLoginScreen();
        } else {
          return _buildMainScreen(json!.lastLogin);
        }
      },
    );
  }

  FutureBuilder<List<User>> _buildLoginScreen() {
    return FutureBuilder<List<User>>(
        future: userList,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            users = snapShot.data;
            return LoginScreen(users: users!);
          } else {
            return const Scaffold(
                body: Center(
              child: Text('No users registered.'),
            ));
          }
        });
  }


  FutureBuilder<User> _buildMainScreen(int? log){
      return FutureBuilder<User>(
        future: restUser.getUsersWithId(log),
        builder: (context, snapShot) {
          if(snapShot.hasData){
            
          }
        }
      )
  }
}
