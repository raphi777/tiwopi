import 'dart:io';
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
  bool _isPlaying = false;
  FlutterSoundPlayer flutterSoundPlayer = FlutterSoundPlayer();

  void _stop() {
    flutterSoundPlayer.closeAudioSession();
  }

  void _play() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = p.join(directory.path, 'record01');
    flutterSoundPlayer.openAudioSession();
    flutterSoundPlayer.startPlayer(fromURI: filePath);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
      onPressed: () {
        if (_isPlaying) {
          _stop();
        } else {
          _play();
        }
        setState(() {
          _isPlaying = !_isPlaying;
        });
      },
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
    await flutterSoundRecorder.startRecorder(toFile: filePath,);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic_rounded),
      onPressed: () {
        if (_isRecording) {
          _stop();
        } else {
          _record();
        }
        setState(() {
          _isRecording = !_isRecording;
        });
      },
    );
  }
}

