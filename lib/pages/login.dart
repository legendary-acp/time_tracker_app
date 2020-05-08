import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetrackerapp/custom_widget/button.dart';
import 'package:timetrackerapp/services/auth.dart';

class Login extends StatelessWidget {
  Login({@required this.auth});
  final AuthBase auth;
  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Time Tracker'),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: _LoginBuild(),
    );
  }
  // ignore: non_constant_identifier_names
  Widget _LoginBuild() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 48.0),
          signin_custom_button(
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/img/google-logo.jpg',
                  height: 30.0,
                ),
                SizedBox(width: 70.0,),
                Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            color: Colors.white,
            onpress: _signInWithGoogle,
          ),
          SizedBox(
            height: 10.0,
          ),
          signin_custom_button(
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/img/facebook-logo.jpg',
                  height: 30.0,
                ),
                SizedBox(width: 70.0,),
                Text(
                  'Sign in with Facebook',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            color: Colors.indigo,
            onpress: () {},
          ),
          SizedBox(
            height: 10.0,
          ),
          signin_custom_button(
            child: Text(
              'Sign in with Email',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            color: Colors.lightGreen,
            onpress: () {},
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          signin_custom_button(
            child: Text(
              'Sign in Anonymously',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            color: Colors.lime,
            onpress: _signInAnonymously,
          )
        ],
      ),
    );
  }

}
