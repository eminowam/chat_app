import 'package:flutter/material.dart';
import 'package:mozz/components/custom_button.dart';
import 'package:mozz/components/custom_text_field.dart';
import 'package:mozz/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
final passwordController2 = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  void signUp() async {
    if (passwordController.text != passwordController2.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Passwords do not match!!!')));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
              "Lets create an account",
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
                title: 'Password',
                obscureText: true),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: passwordController2,
                title: 'Confirm password',
                obscureText: true),
            SizedBox(
              height: 25,
            ),
            CustomButton(
              title: 'Sign Up',
              onTap: signUp,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already a member?',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Log In',
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
