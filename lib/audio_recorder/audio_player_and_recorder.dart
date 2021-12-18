import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class PlaybackButton extends StatefulWidget {
  @override
  _PlaybackButtonState createState() => _PlaybackButtonState();
}

class _PlaybackButtonState extends State<PlaybackButton> {
  void trackValid() {
    print(_loadTrack().runtimeType);
  }

  Future<Track> _loadTrack() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = p.join(directory.path, 'record01');
    return new Track(trackPath: filePath);
  }

  @override
  Widget build(BuildContext context) {
    var player = SoundPlayerUI.fromLoader((context) => _loadTrack());
    return Column(
      children: [
        player,
      ],
    );
  }
}

class RecordButton extends StatefulWidget {
  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool _isRecording = false;
  FlutterSoundRecorder flutterSoundRecorder = new FlutterSoundRecorder();

  void _stop() {
    flutterSoundRecorder.closeAudioSession();
  }

  void _record() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = p.join(directory.path, 'record01');
    print("File Path" + filePath);

    flutterSoundRecorder.openAudioSession();

    PermissionStatus permissionStatus = await Permission.microphone.request();
    if (permissionStatus.isDenied) {
      throw RecordingPermissionException("Microphone permission not granted");
    }
    await flutterSoundRecorder.startRecorder(
        toFile: filePath);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _record();
        print("record");
        setState(() {
          _isRecording = !_isRecording;
        });
      },
      onTapCancel: () {
        _stop();
        setState(() {
          _isRecording = !_isRecording;
        });
      },
      child: IconButton(
        onPressed: () {},
        iconSize: 100,
        //icon: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic_rounded),
        icon: Icon(Icons.mic_rounded),
        color: _isRecording ? Colors.red : Colors.black,
      ),
    );
  }
}
