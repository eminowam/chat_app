import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.title,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),

          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.grey[400],
          filled: true,
          hintText: title,
          hintStyle: TextStyle(color: Colors.grey[700])),
    );
  }
}
