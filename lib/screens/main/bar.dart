import "package:flutter/material.dart";
import "../../models/user.dart";
import "../../screens/login/login_screen.dart";
import "../../services/task_service.dart";
import "../../dependencies.dart";
import "../main/main_screen.dart";

class Bar extends StatefulWidget  implements PreferredSizeWidget {
  final user;
  final users;
  const Bar({Key? key, required this.user, required this.users}) : super(key: key);
  
  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  // final restUser = ;
  get userTask => service<TaskDataService>();
  get userList => userTask.getUsers();
  // final users;
  void navigateLoginScreen(List<User> list) async {
     await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(users: list),
        )
    );
  }

  void navigateHere(User user, List<User> users) async {
     await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainScreen(user: user,  users:users),
    ));
  }
   void updateTask() async {
    await userTask.updateUserLogin(widget.user!.userId);
    setState(() {
      // visibleIncorrect = false;
      // visibleCorrect = true;
    });
   }


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
		  width: 200,
		  height: 200,
		  decoration: const BoxDecoration(
		  shape: BoxShape.circle,
		  image: DecorationImage(
		    image: AssetImage('images/606666.png'),
		    fit: BoxFit.fill
		  ),
		  ),
),
title: Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Text>[
    const Text("My Todo List"),
    Text("${widget.user.name}", 
    style: const TextStyle(
      fontSize: 15,
      color: Colors.grey,
    )),
  ]
),
actions: <Widget>[
  ElevatedButton(
    child: Icon(Icons.logout),
    onPressed: () async { 
      updateTask();
      navigateLoginScreen(widget.users);
    },
  ),
 
      ],
    );
  }
}


















