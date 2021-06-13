import 'package:connecticus/widgets/header.dart';
import 'package:flutter/material.dart';

class ActivityFeed extends StatefulWidget {
  ActivityFeed({Key? key}) : super(key: key);

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: 'Activity Feed'),
      body: Center(
        child: Text('Activity Feed Screen'),
      ),
    );
  }
}
