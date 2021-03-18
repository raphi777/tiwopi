import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:tiwopi/users/create_profile_gender_page.dart';

class CreateProfileAgePage extends StatelessWidget {
  final TiwopiUser tiwopiUser;

  CreateProfileAgePage(this.tiwopiUser);

  bool _birthdayIsValid(context, int year, int month, int day) {
    // check if user is at least 16 years old
    if (year < 1900) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Year.")));
      return false;
    }
    if (month > 12) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Month.")));
      return false;
    }
    if (day > 31) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Day.")));
      return false;
    }

    DateTime birthday = new DateTime(year, month, day);
    if (DateTime.now().difference(birthday).inDays > 5840) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Users must me at least 16 years old.")));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController dayController = TextEditingController();
    final TextEditingController monthController = TextEditingController();
    final TextEditingController yearController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Age'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "My birthday is",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Flexible(
                  child: TextField(
                    controller: dayController,
                    maxLength: 2,
                    decoration: InputDecoration(
                      labelText: "DD",
                      counterText: "",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                new Flexible(
                  child: Text("/"),
                ),
                new Flexible(
                  child: TextField(
                    controller: monthController,
                    maxLength: 2,
                    decoration: InputDecoration(
                      labelText: "MM",
                      counterText: "",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                new Flexible(
                  child: Text("/"),
                ),
                new Flexible(
                  child: TextField(
                    controller: yearController,
                    maxLength: 4,
                    decoration: InputDecoration(
                      labelText: "YYYY",
                      counterText: "",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Your age will be public to other users.",
              style: TextStyle(fontSize: 15),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (yearController.text.isNotEmpty &&
                  monthController.text.isNotEmpty &&
                  dayController.text.isNotEmpty) {
                if (_birthdayIsValid(
                    context,
                    int.parse(yearController.text),
                    int.parse(monthController.text),
                    int.parse(dayController.text))) {
                  tiwopiUser.ownAge = new DateTime(
                      int.parse(yearController.text),
                      int.parse(monthController.text),
                      int.parse(dayController.text));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateProfileGenderPage(tiwopiUser)));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter full date of birth.")));
              }
            },
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}
