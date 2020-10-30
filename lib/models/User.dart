import 'dart:convert';

import 'package:LaraFlutter/values/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class User {
  String name;
  String email;
  String password;

  var body;
  var statusCode;
  var response;

  Future<http.Request> createUser () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    response = await http.post(strings.createUserUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
      body: {
        "name": this.name,
        "email": this.email,
        "password": this.password
      }
    );

    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    return null;
  }

  Future<http.Request> updateUser (int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    response = await http.put("${strings.createUserUrl}/$id",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
        body: {
          "name": this.name,
          "email": this.email
        }
    );

    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    return null;
  }

  Future<http.Request> deleteUser (int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    response = await http.delete("${strings.createUserUrl}/$id",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
    );

    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    return null;
  }
}