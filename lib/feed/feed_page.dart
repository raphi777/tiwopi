import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class FeedPage extends StatefulWidget {
  final int index;

  FeedPage(this.index);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  TiwopiUser user = new TiwopiUser();
  CardController controller;

  Future<List<TiwopiUser>> _getUsers() async {
    List<TiwopiUser> users = [];
    var currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    querySnapshot.docs.removeWhere((element) => element.id == currentUser.uid);

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      TiwopiUser tmpUser = new TiwopiUser();
      tmpUser.fromMap(querySnapshot.docs[i].data());
      users.add(tmpUser);
    }
    return users;
  }

  /* play audio file of user */
  _play() async {
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
      body: new Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: _getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          height: MediaQuery.of(context).size.height / 1.7,
                          child: new TinderSwapCard(
                            swipeUp: true,
                            swipeDown: true,
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: snapshot.data.length,
                            stackNum: 2,
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            maxHeight: MediaQuery.of(context).size.height / 1.6,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            minHeight: MediaQuery.of(context).size.height / 1.7,
                            cardBuilder: (context, index) => Stack(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        snapshot.data[index].imageFileUrls[0],
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 400, left: 50),
                                  child: Text(
                                    snapshot.data[index].name,
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ],
                            ),
                            cardController: controller = CardController(),
                            swipeUpdateCallback:
                                (DragUpdateDetails details, Alignment align) {
                              // get swiping card's alignment
                              if (align.x < 0) {
                              } else if (align.x > 0) {
                                // card is RIGHT swiping
                              }
                            },
                            swipeCompleteCallback:
                                (CardSwipeOrientation orientation, int index) {
                              if (orientation == CardSwipeOrientation.LEFT) {
                                print("LEFT");
                                index += 1;
                                print(index);
                                print(snapshot.data[index].name);
                              } else if (orientation ==
                                  CardSwipeOrientation.RIGHT) {
                                print("RIGHT");
                                index += 1;
                                print(index);
                                print(snapshot.data[index].name);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 10,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: CircularProgressIndicator(),
                        ));
                  }
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
                          /*int _index;
                          if (widget.index <= userIdList.length - 2) {
                            _index = widget.index + 1;
                          } else {
                            _index = 0;
                          }*/
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(index: _index),
                              ),
                            );*/
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
