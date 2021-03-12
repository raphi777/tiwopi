import 'package:flutter/material.dart';
import 'package:tiwopi/authentication/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:tiwopi/authentication/sign_up_page.dart';
import 'package:passwordfield/passwordfield.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signIn(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
    final signInResult = await context.read<AuthenticationService>().signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim()
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(signInResult.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          PasswordField(
            controller: passwordController,
            hintText: "Password",
          ),
          ElevatedButton(
              onPressed: () {
                _signIn(context, emailController, passwordController);
              },
              child: Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
            child: Text("Go to Register"),
          )
        ],
      ),
    );
  }
}