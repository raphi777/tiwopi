import 'package:flutter/material.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:tiwopi/users/create_profile_age_page.dart';

class CreateProfileNamePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TiwopiUser tiwopiUser;

  CreateProfileNamePage(this.tiwopiUser);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "My first name is",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Your Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Your first name will be displayed to other users. \n It can not be changed later.",
              style: TextStyle(fontSize: 15),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                tiwopiUser.name = nameController.text.trim();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateProfileAgePage(
                            tiwopiUser)));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter your first name.")));
              }
            },
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}
