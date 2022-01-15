import "package:flutter/material.dart";
// import "../../models/todo.dart";
import "../../models/user.dart";
import "../../dependencies.dart";
import "../../services/todo_service.dart";
import "../../screens/main/main_screen.dart";

class Body extends StatefulWidget {
  List<User> list;
  Body({Key? key, required this.list}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final restUser = ;
  get todoList => service<TodoDataService>();
  // List<User> users;
  final nameController = TextEditingController();
  final passController = TextEditingController();
  bool visibleCorrect = false, visibleIncorrect  = false, color = false;
  User? user;


  void _navigateMainScreen() async {
      final response = Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MainScreen(user:user)),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Row(
            children: <Widget>[
               const Expanded(
                flex: 1,
                child: Icon(Icons.people),
              ), 
              Expanded(
                flex: 7,
                child:   TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                  hintText: 'Name',
                  ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }else if(!color){
                  return " ";
                }
                return null;
              },
            ),
              ),
            ]
           ),
            Row(children: <Widget>[
              const Expanded(
                flex: 1,
                child: Icon(Icons.password),
              ),
              Expanded(
                flex: 7,
                child: TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }else if(!color){
                      return " ";
                    }
                    return null;
                  },
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Visibility(
                  child: const Text("Incorrect password or username", 
                  style: TextStyle(
                    color: Colors.red,
                  )),
                  visible: visibleIncorrect, 
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Visibility(
                  child: const Text("Correct",
                  style: TextStyle(
                        color: Colors.green,
                      )),
                  visible: visibleCorrect,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
             
                  if (_formKey.currentState!.validate()) {
                      for(int index = 0; index < widget.list.length; index++) {
                          if(nameController.text == widget.list[index].name 
                          && passController.text == widget.list[index].password){
                            user = widget.list[index];
                            color = true;
                          }
                      }
                    
                    if(!color){
                      setState((){ 
                        visibleIncorrect = true;
                        visibleCorrect = false; 
                      });
                    }else{
                      setState((){
                         visibleCorrect = true;
                         visibleIncorrect = false;
                      });
                    }
                      
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

