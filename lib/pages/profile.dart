import 'package:connecticus/widgets/header.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: 'Profile'),
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
