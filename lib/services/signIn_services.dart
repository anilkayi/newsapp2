import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp2/UI/logIn_page.dart';

class signInClass {
  void SignIn(
    String email,
    String password,
    BuildContext context,
  ) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }).catchError((error) {
      Fluttertoast.showToast(msg: error);
    });
  }
}
