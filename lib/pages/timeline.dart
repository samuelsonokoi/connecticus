import 'package:connecticus/widgets/header.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Center(
        child: Text('Timeline Screen'),
      ),
    );
  }
}
