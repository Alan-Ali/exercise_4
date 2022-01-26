class User{
  int id,userIdd;
  String name, password;

  User({this.id = 0,required this.userIdd, required this.name, required this.password});
  User.fromJson(Map<String, dynamic> json) 
  : this(
    id: json['id'],
    userIdd: json["userIdd"],
    name: json["name"],
    password: json["password"],
  );


}