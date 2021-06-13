import 'package:connecticus/models/utils.dart';
import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String title = ''}) {
  return AppBar(
    title: Text(
      isAppTitle ? getAppName() : title,
      style: TextStyle(
        color: Colors.white,
        fontSize: isAppTitle ? 30 : 22,
        fontFamily: 'Nunito',
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
  );
}
