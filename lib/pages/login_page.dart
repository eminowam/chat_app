import 'package:flutter/material.dart';
import 'package:mozz/components/custom_button.dart';
import 'package:mozz/components/custom_text_field.dart';
import 'package:mozz/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Icon(
              Icons.message,
              size: 80,
              color: Colors.grey,
            ),
            Text(
              "Welcome back",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: emailController,
                title: 'Email',
                obscureText: false),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: passwordController,
                title: 'password',
                obscureText: true),
            SizedBox(
              height: 25,
            ),
            CustomButton(
              title: 'Sign In',
              onTap: signIn,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Register',
                        style:
                            TextStyle(fontSize: 15, color: Colors.blue[800])))
              ],
            )
          ],
        ),
      ),
    );
  }
}
