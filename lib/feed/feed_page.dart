import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

import '../home_page.dart';

class FeedPage extends StatefulWidget {
  final int index;

  FeedPage(this.index);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  TiwopiUser user = new TiwopiUser();
  var userIdList = [];

  Future<Widget> _getPicture() async {
    Image image;
    //var currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    userIdList = querySnapshot.docs;
    print(userIdList[widget.index].id);

    await FirebaseFirestore.instance
        .doc('users/' + userIdList[widget.index].id)
        .get()
        .then((snapshot) {
      user.fromMap(snapshot.data());
      image = Image.network(
        user.imageFileUrls[0].toString(),
        fit: BoxFit.fill,
      );
    });
    return image;
  }

  _play() async {
    /*AudioPlayer audioPlayer = AudioPlayer();
    //int result = await audioPlayer.play(user.audioFileUrl);
    int result = await audioPlayer.play("assets/sounds/song.mp3");
    if (result == 1) {
      print("something was played");
      // success
    }*/

    AssetsAudioPlayer.newPlayer().open(
      Audio.network(user.audioFileUrl),
      showNotification: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FutureBuilder(
                future: _getPicture(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            user.name,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: snapshot.data,
                          ),
                        ),
                      ],
                    );

                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Container(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 10,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: CircularProgressIndicator(),
                        ));
                  return Container();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: RawMaterialButton(
                        child: Icon(
                          Icons.close,
                          size: 50,
                          color: Colors.white,
                        ),
                        shape: CircleBorder(),
                        fillColor: Colors.grey,
                        elevation: 2.0,
                        padding: EdgeInsets.all(10.0),
                        onPressed: () {
                          int _index;
                          if (widget.index <= userIdList.length - 2) {
                            _index = widget.index + 1;
                          } else {
                            _index = 0;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(index: _index),
                            ),
                          );
                        },
                      ),
                    ),
                    RawMaterialButton(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                      shape: CircleBorder(),
                      fillColor: Colors.grey,
                      elevation: 2.0,
                      padding: EdgeInsets.all(10.0),
                      onPressed: () {
                        _play();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: RawMaterialButton(
                        child: Icon(
                          Icons.favorite,
                          size: 50,
                          color: Colors.white,
                        ),
                        shape: CircleBorder(),
                        fillColor: Colors.grey,
                        elevation: 2.0,
                        padding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
