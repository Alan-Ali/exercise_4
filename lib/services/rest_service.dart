import "dart:convert";
// ignore: import_of_legacy_library_into_null_safe
import "package:http/http.dart" as http;
import 'package:network_info_plus/network_info_plus.dart';
import "../models/todo.dart";
import "../models/log.dart";

final info = NetworkInfo();

var wifiBSSID = info.getWifiBSSID(); // 11:22:33:44:55:66
var wifiIP = info.getWifiIP(); // 192.168.1.1
var wifiName = info.getWifiName(); // FooNetwork


class RestService {

  final String url = "http://192.168.0.123:3000";

  Future<List<dynamic>> get(String endpoint) async {
      final response = await http.get("$url/$endpoint",
      headers: {"Content-Type": "application/json"});

      if(response.statusCode == 200){
        return jsonDecode(response.body);
      } throw response;   
  
  }

  Future<dynamic> post(String endpoint, {required Todo todo}) async {
    final response = await http.post("$url/$endpoint",
    headers: {"Content-Type": "application/json"}, body: jsonEncode(todo));

    if(response.statusCode == 201 ){
      return jsonDecode(response.body);
    }throw response;

  }

  Future<dynamic> patch(String endpoint, {dynamic data}) async {
    final response = await http.patch("$url/$endpoint", 
    headers: {"Content-Type": "application/json"}, body: jsonEncode(data.toJson()) );

    if(response.statusCode == 200){
        return jsonDecode(response.body);
    }throw response; 

  }



  Future<dynamic> delete(int id,String endpoint) async {
    // final response = await http.delete("$url/$endpoint");
    final request = http.Request("DELETE", Uri.parse("$url/$endpoint"));
    request.body = jsonEncode({'id': id});
    request.headers.addAll({"Content-Type": "application/json"});

    final response = await request.send();
    if(response.statusCode == 200){
      return print("delete Success");
    }throw response;

  } 

  /* this will return the log of the */
  Future<dynamic> logs() async {
      final response = await http.get('$url/logs');
      return jsonDecode(response.body); 
  }


  Future updateLog(int id) async {
    final response = await logs();
    Logs json = Logs.fromJson(json:response);
    json.log = json.log;
    json.lastLogin = id;
    await patch('logs', data: json);
  }

  // Future<int> lastLog() async {
  //   final response = await http.get('$url/logs');

  //   return jsonDecode(response.body);
  // }


}


