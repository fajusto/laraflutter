import 'package:LaraFlutter/views/Login.dart';
import 'package:LaraFlutter/animations/Animations.dart';
import 'package:LaraFlutter/models/Auth.dart';
import 'package:LaraFlutter/models/User.dart';
import 'package:LaraFlutter/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Auth auth = Auth();
  User user = User();
  Strings strings = Strings();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  int _userId;
  bool _editing = false;
  String _token;

  _getUserData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.get("token");
    if(_token == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Login()));
    } else {
     User user = await auth.me();
     _nameController.text = user.name;
     _emailController.text = user.email;
     _userId = user.id;
    }

  }

  void _edit() async {
    if (_editing == true){
      if(_fbKey.currentState.validate()){
        setState(() {
          user.name = _nameController.text;
          user.email = _emailController.text;
        });
        await user.updateUser(_userId);
        setState(() {
          _editing = false;
          Animations.userUpdateToast();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {

    var form = Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: FormBuilder(
          key: _fbKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              FormBuilderTextField(
                attribute: "name",
                controller: _nameController,
                readOnly: _editing == false ? true : false,
                decoration: InputDecoration(
                  labelText: strings.name
                ),
                validators: [
                  FormBuilderValidators.required(errorText: strings.required),
                  FormBuilderValidators.maxLength(100, errorText: "${strings.maxLength}100"),
                  FormBuilderValidators.minLength(3, errorText: "${strings.minLength}3")
                ],
              ),
              FormBuilderTextField(
                attribute: "email",
                controller: _emailController,
                readOnly: _editing == false ? true : false,
                decoration: InputDecoration(
                  labelText: strings.email
                ),
                validators: [
                  FormBuilderValidators.required(errorText: strings.required),
                  FormBuilderValidators.email(errorText: strings.validEmail)
                ],
              ),
            ],
          )
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Home"),
            FlatButton(onPressed: () async {
              await auth.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Login()));
            },
                child: Text("Deslogar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                )
            )
          ],
        ),

      ),
      floatingActionButton: _editing == false ? FloatingActionButton(
        elevation: 0,
        onPressed: (){
          setState(() {
            _editing = true;
          });
        },
        child: Icon(Icons.edit),
      )
        : FloatingActionButton(
        elevation: 0,
        onPressed: _edit,
        child: Icon(Icons.save),
      ),
      body: Container(
        child: Column(
          children: [
            form,
          ],
        ),
      ),
    );
  }
}
