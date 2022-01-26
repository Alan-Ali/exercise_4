import "package:flutter/material.dart";
// import "../../models/todo.dart";
import "../../models/user.dart";
import "../../dependencies.dart";
import "../../services/todo_service.dart";
import "../../screens/main/main_screen.dart";
import "../../services/task_service.dart";

class Body extends StatefulWidget {
  List<User>? list;
  Body({Key? key, required this.list}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  get todoList => service<TodoDataService>();
  get userTask => service<TaskDataService>();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  bool visibleCorrect = false, visibleIncorrect  = false;
  // bool colored = false;
  User? user;


  void _navigateMainScreen(User? user, List<User>? users) async {
      // final response = 
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MainScreen(user:user!, users: users!)),
      );
  }

  void updateTask() async {
    await userTask.updateUserLogin(user!.userIdd);
      setState(() {
      // visibleIncorrect = false;
      // visibleCorrect = true;
    });
    _navigateMainScreen(user!, widget.list!);
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
                    }
                    return null;
                  },
                ),
              ),
            ]),
            Visibility(
              visible: visibleIncorrect,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Incorrect password or Email', 
                  style: TextStyle(
                    color: Colors.red,
                  )),
                )
              )
            ),
                Visibility(
                visible: visibleCorrect,
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Correct',
                          style: TextStyle(
                            color: Colors.red,
                          )),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      
                      if (_formKey.currentState!.validate()) {
                         bool value = false;
                          for(int index = 0; index < widget.list!.length; index++) {
                              if(nameController.text == widget.list![index].name 
                              && passController.text == widget.list![index].password){
                                user = widget.list![index];
                                value = true;
                                break;
                              }
                          }
                        
                        if(!value){
                          setState((){ 
                            visibleIncorrect = true;
                            visibleCorrect = false; 
                          });
                        }else{
                         updateTask();
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                          nameController.clear();
                          passController.clear();
                      }
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

