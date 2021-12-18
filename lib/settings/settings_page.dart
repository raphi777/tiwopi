import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiwopi/authentication/authentication_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signOut(BuildContext context) async {
    try {
      final _auth = Provider.of<AuthenticationService>(context, listen: false);
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
                _auth.currentUser.email.toString() + " " + _auth.currentUser.uid),
            ElevatedButton(
                onPressed: () => _signOut(context), child: Text("Sign out")),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


