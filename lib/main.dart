import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mozz/firebase_options.dart';
import 'package:mozz/my_app.dart';
import 'package:mozz/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => AuthService(), child: const MyApp()));
}
