import 'package:flutter/material.dart';
import 'package:mozz/chat_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title : 'Chat App' ,
      theme : ThemeData (
        primarySwatch : Colors.blue,
      ),
      home : ChatScreen (),
    );
  }
}
