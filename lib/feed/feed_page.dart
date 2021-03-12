import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView.builder(
          itemCount: 500,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Text('Name of User ${index + 1}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Some user Bio'),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
