import "dart:convert";
import "../models/user.dart";
import "rest_service.dart";
import "../dependencies.dart";
import "../models/log.dart";

class TaskDataService{
  final rest = service<RestService>();

  Future<List<User>> getUsers() async {
    final response = await rest.get("users");

    return response.map((json) => User.fromJson(json)).toList();
  }

  Future<dynamic> getUser(String password, String name) async {
      List<User> users = await getUsers();
      
      dynamic user = users.firstWhere(
        (element) => element.name == name && element.password == password );

      if(user) return user;
      else return false;
  }

   Future<User> getUserWithId(int userId) async {
        final users = await getUsers();
        
    User? user = users.firstWhere(
        (element) => element.userId == userId);

      return user;
   }

  Future<Logs> userLogin() async {
        final response = await rest.logs();
        Logs json = Logs.fromJson(json: response);
        return json;
  }

  Future updateUserLogin() async {
    await rest.updateLog(); 
  }

  // Future<int> lastUserLog() async { 
  //   return await rest.
  // }



}



