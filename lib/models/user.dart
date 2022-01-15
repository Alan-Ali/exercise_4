class User{
  int id,userId;
  String name, password;

  User({this.id = 0,required this.userId, required this.name, required this.password});
  User.fromJson(Map<String, dynamic> json) 
  : this(
    id: json['id'],
    userId: json["userId"],
    name: json["name"],
    password: json["password"],
  );


}