import 'package:flutter/material.dart';
import 'package:tiwopi/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

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
        title: const Text("TiWoPi"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("HOME"),
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