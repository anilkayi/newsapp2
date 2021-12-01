import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp2/passinput.dart';
import 'package:newsapp2/services/login_services.dart';
import 'package:newsapp2/style.dart';
import 'package:newsapp2/textinput.dart';
import 'signIn_page.dart';
import 'package:newsapp2/generated/l10n.dart';

class Login extends StatefulWidget {
  String email;
  String password;

  Login(this.email, this.password);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginInClass login = LoginInClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/firebase.png'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(''),
                TextInput(
                    user: email,
                    icon: Icons.email,
                    hint: 'Email',
                    renk: Colors.black.withOpacity(0.5)),
                SizedBox(
                  height: 10,
                ),
                PassInput(
                    pass: password,
                    hint: 'Password',
                    icon: Icons.password,
                    renk: Colors.black.withOpacity(0.5)),
                ElevatedButton(
                  onPressed: () {
                    login.LoginIn(email.text, password.text, context);
                    email.clear();
                    password.clear();

                    {
                      Fluttertoast.showToast(
                          msg: 'Email or Password is incorrect');
                    }
                  },
                  child: Text(
                    S.of(context).buttonTextLogin,
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an accont?',
                      style: buildTextStyle(15, Colors.black, FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text(
                        'Sign up!',
                        style: buildTextStyle(15, Colors.blue, FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
