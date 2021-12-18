import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tiwopi/authentication/authentication_widget.dart';
import 'package:tiwopi/users/add_user.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileAddPicturesPage extends StatefulWidget {
  final TiwopiUser tiwopiUser;

  CreateProfileAddPicturesPage(this.tiwopiUser);

  final _imagePath = List<File>.filled(6, null);

  @override
  _CreateProfileAddPicturesPageState createState() =>
      _CreateProfileAddPicturesPageState();
}

class _CreateProfileAddPicturesPageState
    extends State<CreateProfileAddPicturesPage> {
  Future _getImage(int i) async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    var imageCropped = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 6, ratioY: 10),
      androidUiSettings: androidUiSettings(),
      iosUiSettings: iosUiSettings(),
    );

    setState(() {
      widget._imagePath[i] = imageCropped;
    });
  }

  static IOSUiSettings iosUiSettings() => IOSUiSettings(
        aspectRatioLockEnabled: false,
      );

  static AndroidUiSettings androidUiSettings() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false,
      );

  bool _picturePicked() {
    final picturePicked = widget._imagePath.any((element) {
      if (element != null) {
        return true;
      }
      return false;
    });
    if (picturePicked) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pictures'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Add Pictures",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 5, right: 20, bottom: 20),
              child: Text(
                "Add at least 1 Picture to continue. Your picture will only be shown to users you matched with.",
                style: TextStyle(fontSize: 15),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(30),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 6 / 10,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _getImage(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget._imagePath[0] == null
                        ? Icon(Icons.add)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(widget._imagePath[0]),
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _getImage(1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget._imagePath[1] == null
                        ? Icon(Icons.add)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(widget._imagePath[1]),
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _getImage(2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget._imagePath[2] == null
                        ? Icon(Icons.add)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(widget._imagePath[2]),
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _getImage(3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget._imagePath[3] == null
                        ? Icon(Icons.add)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(widget._imagePath[3]),
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _getImage(4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget._imagePath[4] == null
                        ? Icon(Icons.add)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(widget._imagePath[4]),
                          ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _getImage(5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: widget._imagePath[5] == null
                        ? Icon(Icons.add)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(widget._imagePath[5]),
                          ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_picturePicked()) {
                      widget.tiwopiUser.imageFiles = widget._imagePath;
                      AddUser().addUserToFirebase(widget.tiwopiUser);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthenticationWidget(),
                        ),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Pick at least one Picture.")));
                    }
                  },
                  child: Text("Finish")),
            ),
          ],
        ),
      ),
    );
  }
}
