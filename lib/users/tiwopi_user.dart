class TiwopiUser {
  String email;
  String name;
  String ownGender;
  String soughtGender;
  DateTime ownAge;
  int soughtAge;
  String sexualOrientation;
  List<String> interests;

  TiwopiUser(
      {this.email,
      this.name,
      this.ownGender,
      this.soughtGender,
      this.ownAge,
      this.soughtAge,
      this.sexualOrientation,
      this.interests});
}
