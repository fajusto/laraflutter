import 'package:LaraFlutter/Login.dart';
import 'package:LaraFlutter/models/Auth.dart';
import 'package:LaraFlutter/models/User.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Auth auth = Auth();
  String _token;
  String _name;
  String _email;

  _getUserData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.get("token");
    if(_token == null){
      Navigator.push(context, MaterialPageRoute(builder: (_)=> Login()));
    } else {
     User user = await auth.me();
     _name = user.name;
     _email = user.email;

    }

  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
    );
  }
}
