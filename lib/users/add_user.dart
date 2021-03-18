import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*class AddUser extends StatelessWidget {
  final String email;
  final String name;
  final String ownGender;
  final String soughtGender;
  final DateTime ownAge;
  final int soughtAge;

  AddUser({this.email="", this.name="", this.ownGender="", this.soughtGender="", this.ownAge,
      this.soughtAge=0});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    Future<void> addUser() {
      return users
          .add({
            'email': email,
            'name': name,
            'ownGender': ownGender,
            'soughtGender': soughtGender,
            'ownAge': ownAge,
            'soughtAge': soughtAge
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Container();
  }
}*/
