import 'package:flutter/material.dart';
import 'package:tiwopi/users/create_profile_show_genders_page.dart';
import 'package:tiwopi/users/tiwopi_user.dart';

class CreateProfileSexualOrientationPage extends StatefulWidget {
  final TiwopiUser tiwopiUser;

  CreateProfileSexualOrientationPage(this.tiwopiUser);

  @override
  _CreateProfileSexualOrientationPageState createState() =>
      _CreateProfileSexualOrientationPageState();
}

class _CreateProfileSexualOrientationPageState
    extends State<CreateProfileSexualOrientationPage> {
  int lastIndex;
  List<bool> _selections = List.filled(4, false);

  String _getSexualOrientation(int index) {
    if (index == 0) {
      return "HETEROSEXUAL";
    }
    if (index == 1) {
      return "HOMOSEXUAL";
    }
    if (index == 2) {
      return "BISEXUAL";
    }
    if (index == 3) {
      return "OTHER";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sexual Orientation'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "My sexual orientation is",
                style: TextStyle(fontSize: 30),
              ),
            ),
            ToggleButtons(
              direction: Axis.vertical,
              constraints: BoxConstraints(minWidth: 150, minHeight: 40),
              renderBorder: true,
              borderRadius: BorderRadius.circular(30),
              borderWidth: 5,
              children: [Text("HETEROSEXUAL"), Text("HOMOSEXUAL"), Text("BISEXUAL"), Text("OTHER")],
              isSelected: _selections,
              onPressed: (int index) {
                setState(() {
                  _selections[0] = false;
                  _selections[1] = false;
                  _selections[2] = false;
                  _selections[3] = false;
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateProfileShowGendersPage(
                                  new TiwopiUser(
                                      email: widget.tiwopiUser.email,
                                      name: widget.tiwopiUser.name,
                                      ownAge: widget.tiwopiUser.ownAge,
                                      ownGender: widget.tiwopiUser.ownGender,
                                      sexualOrientation: _getSexualOrientation(lastIndex),))));
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
