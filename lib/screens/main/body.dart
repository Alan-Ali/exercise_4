import "package:flutter/material.dart";
import "../../models/todo.dart";
import "../../services/todo_service.dart";
import "../../dependencies.dart";



class Body extends StatefulWidget{
  List<Todo> list;
  Body({Key? key, required this.list}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>{
  // final restUser = ; 
  get todoList => service<TodoDataService>();
  Todo? _todo;

  @override
  Widget build(BuildContext context){
    return ListView.separated(
      itemBuilder: (context, index) {
        _todo = widget.list[index];

        return ListTile(
          title: Text(_todo!.title), 
          subtitle: Text(_todo!.body), 
          onTap: (){},
          onLongPress: (){},
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
      ),
      itemCount: widget.list.length);
  }

}






