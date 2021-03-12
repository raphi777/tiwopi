import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiwopi/authentication/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:tiwopi/feed/feed_page.dart';
import 'package:tiwopi/records/recording_page.dart';
import 'package:tiwopi/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [RecordingPage(), FeedPage(), SettingsPage()];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Record"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> _signOut(BuildContext context) async {
  try {
    final auth = Provider.of<AuthenticationService>(context, listen: false);
    await auth.signOut();
  } catch (e) {
    print(e);
  }
}
