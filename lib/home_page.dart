import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiwopi/authentication/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthenticationService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(auth.currentUser.email.toString() + " " + auth.currentUser.uid),
            ElevatedButton(
                onPressed: () => _signOut(context),
                child: Text("Sign out")
            ),
          ],
        ),
      ),
    );
  }
}