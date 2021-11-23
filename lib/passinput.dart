import 'package:flutter/material.dart';
import 'package:newsapp2/style.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PassInput extends StatefulWidget {
  const PassInput(
      {Key? key,
      required this.pass,
      required this.hint,
      required this.icon,
      required this.renk})
      : super(key: key);

  final TextEditingController pass;
  final IconData icon;
  final String hint;
  final Color renk;

  @override
  _PassInputState createState() => _PassInputState();
}

class _PassInputState extends State<PassInput> {
  bool showpw = true;
  void pwBak() {
    setState(() {
      showpw = !showpw;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? password;
    return Container(
      decoration: BoxDecoration(
          color: widget.renk, borderRadius: BorderRadius.circular(16)),
      child: TextField(
        onChanged: (userpass) {
          userpass = password!;
        },
        onTap: () {
          if (password!.length > 6) {}
        },
        obscureText: showpw,
        style: buildTextStyle(15, Colors.white, FontWeight.bold),
        controller: widget.pass,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: pwBak,
              child: Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            prefixIcon: Icon(
              widget.icon,
              color: Colors.white,
              size: 25,
            ),
            hintText: widget.hint,
            hintStyle: buildTextStyle(15, Colors.white, FontWeight.bold),
            border: InputBorder.none),
      ),
    );
  }
}
