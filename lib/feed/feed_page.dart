import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiwopi/feed/feedback_position_provider.dart';
import 'package:tiwopi/feed/user_card_widget.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';

class FeedPage extends StatefulWidget {
  final int index;

  FeedPage(this.index);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  List<TiwopiUser> users = [];
  TiwopiUser user = new TiwopiUser();
  //var userIdList;
  CardController controller;
  int _index = 0;

  //List<TiwopiUser> shownUsers;
  bool _usersAreLoaded = false;

  /* get pictures of users and remove own user from list */
  Future<Widget> _getPicture() async {
    Image image;
    var userIdList;
    var currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    userIdList = querySnapshot.docs;
    userIdList.removeWhere((element) => element.id == currentUser.uid);
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

    /*image = Image.network(
      _user.imageFileUrls[0].toString(),
      fit: BoxFit.fill,
    );*/
    return image;
  }

  Future<List<TiwopiUser>> _getUsers() async {
    //List<TiwopiUser> shownUsers = [];
    var userIdList;
    var currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    userIdList = querySnapshot.docs;
    userIdList.removeWhere((element) => element.id == currentUser.uid);

    for (var i = 0; i < userIdList.length; i++) {
      //print(userIdList[i].toString());
      await FirebaseFirestore.instance
          .doc('users/' + userIdList[i].id)
          .get()
          .then((snapshot) {
        user.fromMap(snapshot.data());
        users.add(user);
        print(user.name);
      });
    }
    //_usersAreLoaded = true;
    //_index = 0;
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Column(
                  children: [
                    users.isEmpty
                        ? Text('No more users')
                        : Stack(children: users.map(buildUser).toList()),
                    Expanded(child: Container()),
                    //BottomButtonsWidget()
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
        ),
      );

  Widget buildUser(TiwopiUser user) {
    final userIndex = users.indexOf(user);
    final isUserInFocus = userIndex == users.length - 1;

    return Listener(
      onPointerMove: (pointerEvent) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      onPointerUp: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      child: Draggable(
        child: UserCardWidget(user: user, isUserInFocus: isUserInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: UserCardWidget(user: user, isUserInFocus: isUserInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, user),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, TiwopiUser user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      user.isSwipedOff = true;
    } else if (details.offset.dx < -minimumDrag) {
      user.isLiked = true;
    }
    setState(() {
      users.remove(user);
    });
  }

  /*@override
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
                  if (snapshot.connectionState == ConnectionState.done)
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            snapshot.data[_index].name,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
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
                            stackNum: 3,
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            maxHeight: MediaQuery.of(context).size.height / 1.6,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            minHeight: MediaQuery.of(context).size.height / 1.7,
                            cardBuilder: (context, index) => Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    snapshot.data[index].imageFileUrls[0],
                                    fit: BoxFit.fill,
                                  )),
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
                              } else if (orientation == CardSwipeOrientation.RIGHT) {
                                print("RIGHT");
                                index += 1;
                                print(index);
                                /*for (var i = 0; i <= users.length; i++) {
                                  print(users[i].name);
                                }*/
                              }
                            },
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
  }*/

  @override
  bool get wantKeepAlive => true;
}
