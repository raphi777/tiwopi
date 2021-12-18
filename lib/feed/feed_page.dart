import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiwopi/feed/feed_play_button.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:tiwopi/feed/feed_like_button.dart';
import 'package:tiwopi/feed/feed_dislike_button.dart';

class FeedPage extends StatefulWidget {
  final int index;

  FeedPage(this.index);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  TiwopiUser user = new TiwopiUser();
  CardController controller = CardController();

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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: new TinderSwapCard(
                              swipeUp: true,
                              swipeDown: true,
                              orientation: AmassOrientation.BOTTOM,
                              totalNum: snapshot.data.length,
                              stackNum: 2,
                              cardController: controller,
                              maxWidth: width,
                              maxHeight: height,
                              minWidth: width * 0.99,
                              minHeight: height * 0.99,
                              cardBuilder: (context, index) => Stack(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          snapshot.data[index].imageFileUrls[0],
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Positioned(
                                    top: height * 0.68,
                                    left: width * 0.1,
                                    child: Text(
                                      snapshot.data[index].name,
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                  FeedLikeButton(controller),
                                  FeedPlayButton(controller, snapshot.data[index].audioFileUrl),
                                  FeedDislikeButton(controller),
                                ],
                              ),
                              swipeUpdateCallback:
                                  (DragUpdateDetails details, Alignment align) {
                                // get swiping card's alignment
                                if (align.x < 0) {
                                } else if (align.x > 0) {
                                  // card is RIGHT swiping
                                }
                              },
                              swipeCompleteCallback:
                                  (CardSwipeOrientation orientation,
                                      int index) {
                                if (orientation == CardSwipeOrientation.LEFT) {
                                  print("LEFT");
                                  print(index);
                                } else if (orientation ==
                                    CardSwipeOrientation.RIGHT) {
                                  print("RIGHT");
                                  print(index);
                                }
                              },
                            ),
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
