import 'package:flutter/material.dart';
import 'package:tiwopi/authentication/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:passwordfield/passwordfield.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PasswordField(
              controller: passwordController,
              hintText: "Password",
              pattern: r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
              errorMessage: "Password must have a minimum of eight characters, at least one letter\nand one number!",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()
              );
              Navigator.pop(context);
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}