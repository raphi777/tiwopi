class TiwopiUser {
  final String email;
  final String name;
  final String ownGender;
  final String soughtGender;
  final DateTime ownAge;
  final int soughtAge;
  final String sexualOrientation;

  TiwopiUser({this.email, this.name, this.ownGender, this.soughtGender, this.ownAge,
      this.soughtAge, this.sexualOrientation});

  set email (String email) {
    this.email = email;
  }
  set name (String name) {
    this.name = name;
  }
  set ownGender (String ownGender) {
    this.ownGender = ownGender;
  }
  set soughtGender (String soughtGender) {
    this.soughtGender = soughtGender;
  }
  set ownAge (DateTime ownAge) {
    this.ownAge = ownAge;
  }
  set soughtAge (int soughtAge) {
    this.soughtAge = soughtAge;
  }
  set sexualOrientation (String sexualOrientation) {
    this.sexualOrientation = sexualOrientation;
  }

}