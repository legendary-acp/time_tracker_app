import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  Home({@required this.onSignOut});
  VoidCallback onSignOut;

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignOut();
    } catch (e) {
      print('This is error ${e.toString()}');
    }
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  FirebaseUser _user;

  @override
  Widget build(BuildContext context) {
    return _HomeBuild();
  }

  Widget _HomeBuild() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          FlatButton(
            child: Text(
                'Log out',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {

            },
          )
        ],
        centerTitle: true,
      ),
    );
  }
}
