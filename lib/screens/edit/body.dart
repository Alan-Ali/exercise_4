import "package:flutter/material.dart";
import "../../dependencies.dart";
import "../../models/todo.dart";
import "../../services/todo_service.dart";
import "../../models/todo.dart";

import "./edit_screen.dart";

class Body extends StatefulWidget{
  Todo? todo;  

  final EditScreenState _state;
 
  Body({Key? key, required this.todo, state}) : _state = state;


  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body>{
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    get todoService => service<TodoDataService>();
    late final titleController = TextEditingController(text: widget.todo!.title);
    late final bodyController = TextEditingController(text: widget.todo!.body);
    late bool isChecked = widget.todo!.completed;


 Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    void updateTodo(String? value1, String? value2) async {
      widget.todo!.body = value1!;
      widget.todo!.title = value2!;
      widget.todo!.completed = isChecked;
      await todoService.updateTodoList(widget.todo!.id, widget.todo);
      _navigateToMain();

    }

    void _navigateToMain() async {
          Navigator.of(context).pop(null);
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children:<Widget>[
                TextFormField(
                controller: titleController,
            decoration:const InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: bodyController,
            decoration:const InputDecoration(labelText: 'Body'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Done"),
                    Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                  updateTodo(bodyController.text, titleController.text);
              },
            ),
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                _navigateToMain();
              },
            ),
            ]
          ),
          ]
        ), 
      ),
    );
  }
}












