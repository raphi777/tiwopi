import 'package:flutter/material.dart';
import 'package:tiwopi/users/create_profile_interests_page.dart';
import 'package:tiwopi/users/tiwopi_user.dart';

class CreateProfileShowGendersPage extends StatefulWidget {
  final TiwopiUser tiwopiUser;

  CreateProfileShowGendersPage(this.tiwopiUser);

  @override
  _CreateProfileShowGendersPageState createState() =>
      _CreateProfileShowGendersPageState();
}

class _CreateProfileShowGendersPageState
    extends State<CreateProfileShowGendersPage> {
  int lastIndex;
  List<bool> _selections = List.filled(3, false);

  String _getSoughtGender(int index) {
    if (index == 0) {
      return "WOMEN";
    }
    if (index == 1) {
      return "MEN";
    }
    if (index == 2) {
      return "ALL";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Gender'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Show",
                style: TextStyle(fontSize: 30),
              ),
            ),
            ToggleButtons(
              direction: Axis.vertical,
              constraints: BoxConstraints(minWidth: 150, minHeight: 40),
              renderBorder: true,
              borderRadius: BorderRadius.circular(30),
              borderWidth: 5,
              children: [Text("WOMEN"), Text("MEN"), Text("ALL")],
              isSelected: _selections,
              onPressed: (int index) {
                setState(() {
                  _selections[0] = false;
                  _selections[1] = false;
                  _selections[2] = false;
                  _selections[index] = !_selections[index];
                  lastIndex = index;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (lastIndex != null) {
                      widget.tiwopiUser.soughtGender =
                          _getSoughtGender(lastIndex);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateProfileInterestsPage(
                            widget.tiwopiUser,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Continue")),
            ),
          ],
        ),
      ),
    );
  }
}
