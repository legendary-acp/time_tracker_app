import 'package:flutter/material.dart';

class EmailSignIn extends StatefulWidget {
  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: _LoginBuild(),
    );
  }

  Widget _LoginBuild(){
    return Container();
  }
}
