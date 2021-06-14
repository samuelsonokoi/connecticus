import 'package:connecticus/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';
import 'pages/home.dart';

void main() async {
  // Initialize widgets
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: getAppName(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.orange,
        brightness: Brightness.dark,
        accentColor: HexColor('#f5f8ff'),
      ),
      home: Home(),
    );
  }
}
