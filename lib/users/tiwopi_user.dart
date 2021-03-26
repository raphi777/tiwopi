import 'dart:io';

class TiwopiUser {
  String email;
  String name;
  String ownGender;
  String soughtGender;
  DateTime ownAge;
  int soughtAge;
  String sexualOrientation;
  List<String> interests;
  String audioFileUrl;
  List<String> imageFileUrls;
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
}
