import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connecticus/widgets/header.dart';
import 'package:connecticus/widgets/progress.dart';
import 'package:flutter/material.dart';

final userRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            userRef.orderBy('username').snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularProgress(context);
          }

          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(
                    'Username: ${data['username']} - ${data['postCount']} post${data['postCount'] > 0 ? 's' : ''}'),
                subtitle: Text('${data['isAdmin'] ? 'Admin' : 'User'}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
