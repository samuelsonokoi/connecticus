import 'package:connecticus/pages/activity_feed.dart';
import 'package:connecticus/pages/profile.dart';
import 'package:connecticus/pages/search.dart';
import 'package:connecticus/pages/timeline.dart';
import 'package:connecticus/pages/upload.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Initialize google signin
final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  login() {
    googleSignIn.signIn();
  }

  logOut() {
    googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });

    // check and log the user in when the app is oppened.
    googleSignIn
        .signInSilently(suppressErrors: false)
        .then((account) => handleSignIn(account))
        .catchError((err) {
      print('Error signing in: $err');
    });
  }

  void handleSignIn(GoogleSignInAccount? account) {
    if (account != null) {
      print('User signed in: $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  Widget buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: [
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
      ),
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: Container(
    //       child: Center(
    //         child: MaterialButton(
    //           onPressed: logOut,
    //           hoverColor: Theme.of(context).accentColor,
    //           color: Colors.orangeAccent[400],
    //           elevation: 8.0,
    //           child: Text(
    //             'Log Out',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 25,
    //               fontFamily: 'Nunito',
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Connecticus-Ng',
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
