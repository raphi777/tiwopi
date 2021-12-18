import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class FeedPlayButton extends StatelessWidget {
  final CardController controller;
  final String audioFileUrl;

  FeedPlayButton(this.controller, this.audioFileUrl);

  /* play audio file of user */
  _play(audioFileUrl) async {
    AssetsAudioPlayer.newPlayer().open(
      Audio.network(audioFileUrl),
      showNotification: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Positioned(
      top: height * 0.6,
      left: width * 0.37,
      child: RawMaterialButton(
        child: Icon(
          Icons.play_arrow_rounded,
          size: 40,
          color: Colors.white,
        ),
        shape: CircleBorder(),
        fillColor: Colors.grey,
        elevation: 2.0,
        padding: EdgeInsets.all(10.0),
        onPressed: () => {_play(audioFileUrl)},
      ),
    );
  }
}
