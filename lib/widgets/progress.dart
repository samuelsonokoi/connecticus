import 'package:flutter/material.dart';

Container circularProgress(context) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(
      top: 20,
    ),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Theme.of(context).primaryColor,
      ),
    ),
  );
}

Container linearProgress(context) {
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Theme.of(context).primaryColor,
      ),
    ),
  );
}
