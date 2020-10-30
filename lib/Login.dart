import 'package:LaraFlutter/animations/Animations.dart';
import 'package:LaraFlutter/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Strings strings = Strings();

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool _loading = false;
  String _emailErrorMsg;
  String _passwordErrorMsg;

  @override
  Widget build(BuildContext context) {

    var banner = Text("Login",
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold
      ),
    );

    var form = Container(
      child: Column(
        children: [
          FormBuilder(
            key: _fbKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: FormBuilder(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: "email",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: strings.email,
                            errorText: _emailErrorMsg,
                            contentPadding:
                            EdgeInsets.fromLTRB(20, 8, 20, 8),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32)),
                          ),
                          validators: [
                            FormBuilderValidators.required(errorText: strings.required),
                            FormBuilderValidators.email(errorText: strings.validEmail)
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: FormBuilderTextField(
                            attribute: "password",
                            controller: _passwordController,
                            obscureText: true,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: strings.password,
                              errorText: _passwordErrorMsg,
                              contentPadding:
                              EdgeInsets.fromLTRB(20, 8, 20, 8),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)),
                            ),
                            validators: [
                              FormBuilderValidators.required(errorText: strings.required),
                              FormBuilderValidators.minLength(6, errorText: "${strings.minLength}6"),
                              FormBuilderValidators.maxLength(40, errorText: "${strings.maxLength}40"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: RaisedButton(
                              child: Text(
                                "Entrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              color: Colors.blue,
                              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              onPressed: () {

                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

    var register = InkWell(
      child: Text("Não tem conta? Cadastre-se!",
        style: TextStyle(
          fontSize: 20,
          color: Colors.blue
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            banner,
            SizedBox(height: 20,),
            form,
            SizedBox(height: 30,),
            register,
            _loading == true ? Animations.loading()
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
