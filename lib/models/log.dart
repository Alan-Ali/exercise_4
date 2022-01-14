class Logs{
  bool log;
  int lastLogin;

  Logs({required this.lastLogin, required this.log});

  Logs.fromJson({Map<String, dynamic>? json}) 
  : this(
    lastLogin: json!['lastLogin'],
    log: json['log']
  );


}