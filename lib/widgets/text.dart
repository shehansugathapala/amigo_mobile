import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign textAlign;

  TextWidget({required this.text, this.textColor = Colors.blue, required this.textAlign, required TextStyle style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign, // Set the text alignment
      style: TextStyle(
        fontSize: 16.0, // Customize the font size as needed
        fontWeight: FontWeight.normal, // Customize the font weight as needed
        color: textColor, // Set the text color
      ),
    );
  }
}
