import 'package:flutter/material.dart';
import 'package:mozz/services/auth/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      home: AuthGate(),
    );
  }
}
