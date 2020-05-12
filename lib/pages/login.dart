import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/custom_widget/button.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:timetrackerapp/pages/sign_in_with_email/email_login.dart';
import 'package:timetrackerapp/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  Future<void> _signInAnonymously(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
    setState(() {
      _isLoading =false;
    });
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    setState(() {
      _isLoading =true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
    setState(() {
      _isLoading =false;
    });
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignIn(),
      ),
    );
  }

  Widget _loginBuild(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _isLoading
              ? SpinKitWave(
                  color: Colors.indigo,
                  size: 50.0,
                )
              : Text(
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
                SizedBox(
                  width: 70.0,
                ),
                Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            color: Colors.white,
            onpress: _isLoading
                ? null : () => _signInWithGoogle(context),
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
                SizedBox(
                  width: 70.0,
                ),
                Text(
                  'Sign in with Facebook',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            color: Colors.indigo,
            onpress: _isLoading
                ? null : () => _signInWithFacebook(context),
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
            onpress: _isLoading
                ? null :  () => _signInWithEmail(context),
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
            onpress: _isLoading
                ? null :  () => _signInAnonymously(context),
          )
        ],
      ),
    );
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
      body: _loginBuild(context),
    );
  }
// ignore: non_constant_identifier_names

}
