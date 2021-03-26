import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:tiwopi/audio_recorder/audio_player_and_recorder.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:path_provider/path_provider.dart';
import 'create_profile_add_pictures_page.dart';

class CreateProfileAddRecordPage extends StatefulWidget {
  final TiwopiUser tiwopiUser;

  CreateProfileAddRecordPage(this.tiwopiUser);

  @override
  _CreateProfileAddRecordPageState createState() =>
      _CreateProfileAddRecordPageState();
}

class _CreateProfileAddRecordPageState
    extends State<CreateProfileAddRecordPage> {
  Future<String> _getAudioPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return p.join(directory.path, 'record01').toString();
  }

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
              child: ElevatedButton(
                  onPressed: () async {
                    String audioFilePath = await _getAudioPath();
                    widget.tiwopiUser.audioFile = File(audioFilePath);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateProfileAddPicturesPage(
                          widget.tiwopiUser,
                        ),
                      ),
                    );
                  },
                  child: Text("Continue")),
            ),
          ],
        ),
      ),
    );
  }
}
