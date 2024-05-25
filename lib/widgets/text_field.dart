import 'package:flutter/material.dart';

class TextFeildInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputkeyboardType;

  const TextFeildInput({
    required this.hintText,
    required this.controller,
    required this.isPassword,
    required this.inputkeyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Customize the color of the outer box
          width: 2.0, // Customize the width of the outer box
        ),
        borderRadius: BorderRadius.circular(8.0), // Customize the border radius
      ),
      child: TextField(
        obscureText: isPassword,
        keyboardType: inputkeyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),

          border: InputBorder.none, // Remove the default border of TextField
        ),
      ),
    );
  }
}
