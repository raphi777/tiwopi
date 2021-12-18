import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiwopi/users/tiwopi_user.dart';
import 'package:tiwopi/feed/feedback_position_provider.dart';

class UserCardWidget extends StatelessWidget {
  final TiwopiUser user;
  final bool isUserInFocus;

  const UserCardWidget({
    @required this.user,
    @required this.isUserInFocus,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackPositionProvider>(context);
    final swipingDirection = provider.swipingDirection;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 1.6,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(user.imageFileUrls[0]),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0.5),
          ],
          gradient: LinearGradient(
            colors: [Colors.black12, Colors.black87],
            begin: Alignment.center,
            stops: [0.4, 1],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              left: 10,
              bottom: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildUserInfo(user: user),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16, right: 8),
                    child: Icon(Icons.info, color: Colors.white),
                  ),
                ],
              ),
            ),
            if (isUserInFocus) buildLikeBadge(swipingDirection)
          ],
        ),
      ),
    );
  }

  Widget buildLikeBadge(SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final color = isSwipingRight ? Colors.green : Colors.pink;
    final angle = isSwipingRight ? -0.5 : 0.5;

    if (swipingDirection == SwipingDirection.none) {
      return Container();
    } else {
      return Positioned(
        top: 20,
        right: isSwipingRight ? null : 20,
        left: isSwipingRight ? 20 : null,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 2),
            ),
            child: Text(
              isSwipingRight ? 'LIKE' : 'NOPE',
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget buildUserInfo({@required TiwopiUser user}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${user.name}, ${user.getAge()}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              // to do: create TiwopiUser param designation
              'some job',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4),
            Text(
              // to do: evtl. create TiwopiUser param 'mutual friedns'
              'mutual friends',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
}
