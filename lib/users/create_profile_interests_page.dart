import 'package:flutter/material.dart';
import 'package:tiwopi/users/tag_item.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:flutter_tags/flutter_tags.dart';

class CreateProfileInterestsPage extends StatefulWidget {
  final TiwopiUser tiwopiUser;

  CreateProfileInterestsPage(this.tiwopiUser);

  @override
  _CreateProfileInterestsPageState createState() =>
      _CreateProfileInterestsPageState();
}

class _CreateProfileInterestsPageState
    extends State<CreateProfileInterestsPage> {
  final GlobalKey<TagsState> _globalKey = GlobalKey<TagsState>();
  List<TagItem> _tagItems = [];
  List _items = [
    Item(title: "Foodie"),
    Item(title: "Music"),
    Item(title: "Cat lover"),
    Item(title: "Running"),
    Item(title: "Soccer"),
    Item(title: "Board Games"),
    Item(title: "Vegetarian")
  ];

  bool _interestsValid(List interests) {
    int cnt = 0;
    print(interests[0].active);
    for (var i = 0; i < interests.length; i++) {
      if (interests[i].active == true) {
        cnt++;
      }
    }
    if (cnt <= 5 && cnt >= 3) {
      print("interests valid");
      return true;
    } else {
      print("abc");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interests'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Interests",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 5, right: 20, bottom: 20),
              child: Text(
                "Share in your profile, what is really important to you.",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Tags(
              key: _globalKey,
              itemCount: _items.length,
              itemBuilder: (int index) {
                //final Item item = _items[index];
                final item = _items[index];
                return ItemTags(
                  index: index,
                  title: item.title,
                  active: false,
                  onPressed: (item) {
                    // add item to _tagItem List if selected, if deselected find item and remove
                    if (item.active == true) {
                      _tagItems.add(TagItem(index: index, title: item.title, active: item.active));
                    } else {
                      for (var i = 0 ; i < _tagItems.length ; i++) {
                        if (_tagItems[i].index == index) {
                          _tagItems.removeAt(i);
                        }
                      }
                    }
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: () {
                    for (var i = 0; i < _tagItems.length; i++){
                      print(_tagItems[i].title + " " + _tagItems[i].active.toString());
                    }
                    //if (_interestsValid(_tagItems)) {}
                  },
                  child: Text("Continue")),
            ),
          ],
        ),
      ),
    );
  }

  /*@override afterFirstLayout(BuildContext context) {
    _tagItemsInitialize(_items);
  }
  void _tagItemsInitialize(List items) {
    for (var i = 0; i < items.length; i++) {
      _tagItems.add(TagItem(index: i, title: items[i].title, active: items[i].active));
    }
  }*/
}
