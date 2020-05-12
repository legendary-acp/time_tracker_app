import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/sign_in_with_email/email_login_form.dart';

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
