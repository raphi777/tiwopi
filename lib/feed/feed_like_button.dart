import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class FeedLikeButton extends StatelessWidget {
  final CardController controller;

  FeedLikeButton(this.controller);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Positioned(
      top: height * 0.6,
      left: width * 0.7,
      child: RawMaterialButton(
        child: Icon(
          Icons.favorite,
          size: 40,
          color: Colors.white,
        ),
        shape: CircleBorder(),
        fillColor: Colors.grey,
        elevation: 2.0,
        padding: EdgeInsets.all(10.0),
        onPressed: () => {controller.triggerRight()},
      ),
    );
  }
}
