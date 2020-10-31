import 'dart:convert';

import 'package:LaraFlutter/models/User.dart';
import 'package:LaraFlutter/values/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Strings strings = Strings();

class Auth {

  var statusCode;
  var body;

  var response;

  Future<http.Response> auth (String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    response = await http.post(strings.authUrl,
      headers: {
        "Accept": "application/json"
      },
      body: {
        "email": email,
        "password": password,
        "device_name": "HSR2203"
      }
    );

    this.statusCode = response.statusCode;
    this.body = response.body;

    print("statuscode: $statusCode");
    print("token: $body");

    if (this.statusCode == 200) {
      prefs.setString("token", response.body);
    }
    return null;
  }

  Future<User> me () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    response = await http.get(strings.meUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
    );
    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    User user = User();
    user.name = data["name"];
    user.email = data["email"];
    user.id = data["id"];
    return user;
  }

  Future<http.Response> logout () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    response = await http.post(strings.logoutUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    this.statusCode = response.statusCode;
    this.body = json.decode(response.body);
    if(this.statusCode == 200){
      prefs.remove("token");
    }
    return null;
  }
}