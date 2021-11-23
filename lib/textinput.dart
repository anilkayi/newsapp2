import 'package:flutter/material.dart';

import 'style.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.user,
    required this.icon,
    required this.hint,
    required this.renk,
  }) : super(key: key);

  final TextEditingController user;
  final IconData icon;
  final String hint;
  final Color renk;

  @override
  Widget build(BuildContext context) {
    String? email;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: renk, borderRadius: BorderRadius.circular(16)),
          child: TextField(
            onChanged: (usermail) {
              usermail = email!;
            },
            style: buildTextStyle(20, Colors.white, FontWeight.bold),
            controller: user,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              prefixIcon: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
              hintText: hint,
              hintStyle: buildTextStyle(15, Colors.white, FontWeight.bold),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }
}
