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
              OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),

          focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          fillColor: Color(0xffEDF2F6),
          filled: true,
          hintText: title,
          hintStyle: TextStyle(color: Colors.grey[700])),
    );
  }
}
