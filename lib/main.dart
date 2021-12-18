import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiwopi/authentication/authentication_service.dart';
import 'package:tiwopi/authentication/authentication_widget.dart';
import 'package:tiwopi/feed/feedback_position_provider.dart';

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
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (context) => FeedbackPositionProvider(),
        ),

        /*Provider<FeedbackPositionProvider>(
            create: (_) => FeedbackPositionProvider(),
          ),*/
      ],
      child: MaterialApp(
        title: 'TiWoPi',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWidget(),
      ),
    );
  }
}
