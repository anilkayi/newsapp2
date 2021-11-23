import 'package:flutter/material.dart';
import 'package:newsapp2/passinput.dart';
import 'package:newsapp2/style.dart';
import 'package:newsapp2/textinput.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/fb.jpg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
            ],
          ),
        ),
      )),
    );
  }
}
