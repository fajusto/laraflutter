import 'package:LaraFlutter/animations/Animations.dart';
import 'package:LaraFlutter/models/User.dart';
import 'package:LaraFlutter/values/strings.dart';
import 'package:LaraFlutter/views/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  Strings strings = Strings();
  User user = User();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confPasswordController = TextEditingController();

  bool _loading = false;

  _setData() async{
    if (_fbKey.currentState.validate()) {
      setState(() {
        _loading = true;
        user.name = _nameController.text;
        user.email = _emailController.text;
        user.password = _passwordController.text;
      });
      await user.createUser();
      if(user.statusCode == 200){
        setState(() {
          _loading = false;
          Animations.userCreateToast();
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> Login()));
      }
    }
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
                decoration: InputDecoration(
                    labelText: strings.email
                ),
                validators: [
                  FormBuilderValidators.required(errorText: strings.required),
                  FormBuilderValidators.email(errorText: strings.validEmail)
                ],
              ),
              FormBuilderTextField(
                attribute: "password",
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: strings.password
                ),
                validators: [
                  FormBuilderValidators.required(errorText: strings.required),
                  FormBuilderValidators.minLength(8, errorText: "${strings.minLength}8"),
                  FormBuilderValidators.maxLength(100, errorText: "${strings.maxLength}100")
                ],
              ),
              FormBuilderTextField(
                attribute: "conf_password",
                controller: _confPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: strings.confPassword
                ),
                validators: [
                  FormBuilderValidators.required(errorText: strings.required),
                  FormBuilderValidators.minLength(8, errorText: "${strings.minLength}8"),
                  FormBuilderValidators.maxLength(100, errorText: "${strings.maxLength}100"),
                  (val){
                    if(val != _fbKey.currentState.fields["password"].currentState.value){
                      return strings.passwordMatch;
                    }
                    return null;
                  }
                ],
              ),
            ],
          )
      ),
    );

    var register = Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: _loading == true ? Animations.loading()
              :  RaisedButton(
            elevation: 0,
            child: Text(
              strings.register,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(32, 10, 32, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)),
            onPressed: _setData,
          ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(strings.register),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            form,
            register,
          ],
        ),
      ),
    );
  }
}
