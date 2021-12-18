import 'package:flutter/material.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'create_profile_add_record_page.dart';

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
  List<String> _interests = [];
  List _items = [
    Item(title: "Foodie"),
    Item(title: "Music"),
    Item(title: "Cat lover"),
    Item(title: "Running"),
    Item(title: "Soccer"),
    Item(title: "Board Games"),
    Item(title: "Vegetarian")
  ];

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
                      _interests.add(item.title);
                    } else {
                      for (var i = 0; i < _interests.length; i++) {
                        if (_interests[i] == item.title) {
                          _interests.removeAt(i);
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
                    if (_interests.length > 2 && _interests.length < 6) {
                      widget.tiwopiUser.interests = _interests;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateProfileAddRecordPage(
                            widget.tiwopiUser,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Continue")),
            ),
          ],
        ),
      ),
    );
  }
}
