import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/home.dart';
import 'package:timetrackerapp/pages/login.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  FirebaseUser _user;

  void _updateUser(FirebaseUser _user) {
    print('It was here');
    setState(() {
      this._user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this._user == null) {
      return Login(
        onSignIn: _updateUser,
      );
    } else {
      return Home(
        onSignOut: () {
          setState(() {
            _user = null;
          });
        },
      );
    }
  }
}
