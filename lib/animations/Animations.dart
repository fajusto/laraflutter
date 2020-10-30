import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Animations{

  static Widget loading(){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: Container(
          width: 30,
          height: 30,
          child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator()
          ),
        ),
      ),
    );
  }
}