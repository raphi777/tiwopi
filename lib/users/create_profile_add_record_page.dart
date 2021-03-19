import 'package:flutter/material.dart';
import 'package:tiwopi/audio_recorder/audio_player_and_recorder.dart';
import 'package:tiwopi/users/tiwopi_user.dart';

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
              child: RecordButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PlaybackButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(onPressed: () {}, child: Text("Continue")),
            ),
          ],
        ),
      ),
    );
  }
}
