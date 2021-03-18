import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:tiwopi/users/create_profile_sexual_orientation_page.dart';

class CreateProfileGenderPage extends StatefulWidget {
  final TiwopiUser tiwopiUser;

  CreateProfileGenderPage(this.tiwopiUser);

  @override
  _CreateProfileGenderPageState createState() =>
      _CreateProfileGenderPageState();
}

class _CreateProfileGenderPageState extends State<CreateProfileGenderPage> {
  int lastIndex;
  List<bool> _selections = List.generate(3, (_) => false);

  String _getGender(int index) {
    if (index == 0) {
      return "FEMALE";
    }
    if (index == 1) {
      return "MALE";
    }
    if (index == 2) {
      return "DIVERSE";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "I identify as",
                style: TextStyle(fontSize: 30),
              ),
            ),
            ToggleButtons(
              direction: Axis.vertical,
              constraints: BoxConstraints(minWidth: 150, minHeight: 40),
              renderBorder: true,
              borderRadius: BorderRadius.circular(30),
              borderWidth: 5,
              children: [Text("FEMALE"), Text("MALE"), Text("DIVERSE")],
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
                      widget.tiwopiUser.ownGender = _getGender(lastIndex);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreateProfileSexualOrientationPage(
                                      widget.tiwopiUser)));
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
