import 'package:flutter/material.dart';
import 'package:tiwopi/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:tiwopi/sign_up_page.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TiWoPi'),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()
                );
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