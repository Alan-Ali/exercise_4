import "package:flutter/material.dart";
import "./bar.dart";
import "../../models/todo.dart";
import "./body.dart";
// import "";
import "dart:async";
StreamController<EditScreenState> streamController = StreamController<EditScreenState>();

class EditScreen extends StatefulWidget {
    Todo? todo;
    final Body _state;
    EditScreen({ required this.todo, state}) : _state = state;
    
    @override
    EditScreenState createState() => EditScreenState();
}


class EditScreenState extends State<EditScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Bar(),
      body: Body(todo: widget.todo, state: widget.createState()),
    );
  }
}