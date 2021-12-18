import 'package:flutter/material.dart';

class RecordingPage extends StatefulWidget {
  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Recording"),
      ),
      body: ListView.builder(
          itemCount: 500,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Text('Record # ${index + 1}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Some record details'),
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
