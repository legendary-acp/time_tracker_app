import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/login/email_signin/email_signin_form.dart';

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
        title: Text('Sign in with Email'),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: SingleChildScrollView(
        child: EmailSignInForm(),
      ),
    );
  }
}
