import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class TiwopiUser {
  String email;
  String name;
  String ownGender;
  String soughtGender;
  DateTime ownAge;
  int soughtAge;
  String sexualOrientation;
  List<dynamic> interests;
  String audioFileUrl;
  List<dynamic> imageFileUrls;
  File audioFile;
  List<File> imageFiles;

  TiwopiUser(
      {this.email,
      this.name,
      this.ownGender,
      this.soughtGender,
      this.ownAge,
      this.soughtAge,
      this.sexualOrientation,
      this.interests,
      this.audioFile,
      this.imageFiles});

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'name' : name,
        'userGender' : ownGender,
        'soughtGender' : soughtGender,
        'userBirthday' : ownAge,
        'soughtAge' : soughtAge,
        'sexualOrientation' : sexualOrientation,
        'interests' : interests,
        'audioFileUrl' : audioFileUrl,
        'imageFileUrls' : imageFileUrls
      };

  void fromMap(Map map) {
    Timestamp time = map['userBirthday'];
    var ownAge = DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
    this.email = map['email'];
    this.name = map['name'];
    this.ownGender = map['userGender'];
    this.soughtGender = map['soughtGender'];
    this.ownAge = ownAge;
    this.soughtAge = map['soughtAge'];
    this.sexualOrientation = map['sexualOrientation'];
    this.interests = map['interests'];
    this.audioFileUrl = map['audioFileUrl'];
    this.imageFileUrls = map['imageFileUrls'];
  }
}
