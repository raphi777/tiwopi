import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiwopi/authentication_service.dart';
import 'package:tiwopi/home_page.dart';
import 'package:tiwopi/sign_in_page.dart';

import 'authentication_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          
          StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,
          ),
        ],
        child: MaterialApp(
          title: 'TiWoPi',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AuthenticationWidget(),
        ),
    );
    /*return Provider<AuthenticationService>(
      builder: (_) => AuthenticationService(FirebaseAuth.instance),
      child: MaterialApp(
        title: 'TiWoPi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWidget(),
      ),
    );*/
  }
}

/*class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    }
    return SignInPage();
  }
}*/
