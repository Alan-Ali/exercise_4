import "package:flutter/material.dart";
import "./body.dart";
import "../../models/user.dart";


class LoginScreen extends StatefulWidget{

  List<User> users;
  LoginScreen({required this.users});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Center(
          child: Text("Login Screen"),
        )
      ),
      body: Text("hello ")
    );
  }


}