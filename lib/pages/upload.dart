import 'package:connecticus/widgets/header.dart';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: 'Upload'),
      body: Center(
        child: Text('Upload Screen'),
      ),
    );
  }
}
