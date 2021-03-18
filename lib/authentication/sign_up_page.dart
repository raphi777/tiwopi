import 'package:flutter/material.dart';
import 'package:tiwopi/authentication/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:tiwopi/users/create_profile_name_page.dart';
import 'package:tiwopi/users/tiwopi_user.dart';

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
              errorMessage:
                  "Password must have a minimum of eight characters, at least one letter\nand one number!",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                context.read<AuthenticationService>().signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProfileNamePage(
                            new TiwopiUser(
                                email: emailController.text.trim(),
                                name: "",
                                ownGender: "",
                                ownAge: DateTime.now(),
                                soughtAge: 0,
                                soughtGender: "",
                                sexualOrientation: "",
                                interests: []))));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter E-Mail and Password.")));
              }
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
