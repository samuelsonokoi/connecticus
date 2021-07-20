import 'package:connecticus/models/utils.dart';
import 'package:connecticus/widgets/header.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? username;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // submit the form and navigate back with the selected username
  void submit() {
    _formKey.currentState!.save();
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: 'Set up your profile'),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Center(
              child: Text(
                'Please select a username',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              child: Form(
                child: TextFormField(
                  onSaved: (value) => username = value,
                  key: _formKey,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: getFontName(),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(fontSize: 25, color: Colors.white),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    hintText: 'Must be at least 3 characters',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: submit,
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: getFontName(),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
