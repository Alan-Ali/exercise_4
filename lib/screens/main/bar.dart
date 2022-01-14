import "package:flutter/material.dart";
import "../../models/user.dart";




class Bar extends StatefulWidget {
  final user;
  Bar({required this.user});

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  // final restUser = ;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Text(''),
    );
  }
}


















