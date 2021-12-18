import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddUser {
  Future<void> addUserToFirebase(TiwopiUser user) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    /* Upload Picture to Storage and Store URL in Firestore */
    user.imageFileUrls = [];
    user.imageFiles.forEach((image) async {
      if (image != null) {
        var uuid = Uuid();
        String refPath = 'users/' +
            currentUser.uid.toString() +
            "/pictures/" +
            uuid.v1().toString();
        Reference storageReference =
            FirebaseStorage.instance.ref().child(refPath);
        UploadTask uploadTask = storageReference.putFile(image);
        uploadTask.whenComplete(() async {
          try {
            user.imageFileUrls.add(await storageReference.getDownloadURL());
            updateFirestore(user, currentUser);
          } on FirebaseException catch (e) {
            print(e);
          }
        });
      }
    });

    /* Upload Audio to Storage and Store URL in Firestore */
    if (user.audioFile != null) {
      var uuid = Uuid();
      String refPath = 'users/' +
          currentUser.uid.toString() +
          "/audios/" +
          uuid.v1().toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child(refPath);
      UploadTask uploadTask = storageReference.putFile(user.audioFile);
      uploadTask.whenComplete(() async {
        try {
          user.audioFileUrl = await storageReference.getDownloadURL();
          updateFirestore(user, currentUser);
        } on FirebaseException catch (e) {
          print(e);
        }
      });
    }
  }

  void updateFirestore(TiwopiUser user, var currentUser) {
    /* Add remaining data to Firestore */
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .set(user.toJson());
  }
}
