import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color textColor;
  final Color hintTextColor;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textColor,
    required this.hintTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: textColor), // Set text color
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Color(0xffF5F6FA),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor, // Set hint text color
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
