import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp2/UI/HomePage.dart';

class LoginInClass {
  void LoginIn(
    String email,
    String password,
    BuildContext context,
  ) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).catchError((error) {
      Fluttertoast.showToast(msg: error);
    });
  }
}
