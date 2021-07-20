import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connecticus/models/utils.dart';
import 'package:connecticus/pages/activity_feed.dart';
import 'package:connecticus/pages/create_account.dart';
import 'package:connecticus/pages/profile.dart';
import 'package:connecticus/pages/search.dart';
import 'package:connecticus/pages/timeline.dart';
import 'package:connecticus/pages/upload.dart';
import 'package:flutter/cupertino.dart';
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
  PageController? pageController;
  int pageIndex = 0;

  login() {
    googleSignIn.signIn();
  }

  logOut() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  // Animate controller
  onTapped(int pageIndex) {
    pageController!.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    // initialize page controller
    pageController = PageController();

    // listen current changes
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

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  void handleSignIn(GoogleSignInAccount? account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  // create user
  createUserInFirestore() async {
    // set user id
    final user = googleSignIn.currentUser;
    // get the user document based on the id
    DocumentSnapshot data = await userRef.doc(user!.id).get();

    // check if the document exist and create it if it doesn't
    if (data.exists) {
    } else {
      // wait for navigator to return with the user's username
      final username = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CreateAccount(),
          ));
      //
      userRef.doc(user.id).set({
        'email': user.email,
        'photoUrl': user.photoUrl,
        'id': user.id,
        'displayName': user.displayName,
        'username': username,
        'postCount': 0,
        'isAdmin': false,
        'bio': '',
        'createAt': DateTime.now(),
      }).then((value) => print('user saved!'));
    }
  }

  Widget buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: [
          // Timeline(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: logOut,
                child: Container(
                  width: 260,
                  height: 60,
                ),
              ),
            ],
          ),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 45.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: onTapped,
        activeColor: Theme.of(context).primaryColor,
      ),
    );
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
              getAppName(),
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
