import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateProfileAddRecordPage extends StatefulWidget {
  final TiwopiUser tiwopiUser;

  CreateProfileAddRecordPage(this.tiwopiUser);

  @override
  _CreateProfileAddRecordPageState createState() =>
      _CreateProfileAddRecordPageState();
}

class _CreateProfileAddRecordPageState
    extends State<CreateProfileAddRecordPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Add Audio Record",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 5, right: 20, bottom: 20),
              child: Text(
                "Your audio record will be played to other users. You can introduce yourself, sing a song or tell a joke. It's up to you. Be creative ;)",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("record");
                    },
                    child: Text("Record"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("... recorder"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("play");
                    },
                    child: Text('Play'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('... player'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*Future<void> _onUploadComplete() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    ListResult listResult =
        await firebaseStorage.ref().child('upload-voice-firebase').list();
    setState(() {
      references = listResult.items;
    });
  }*/
}
