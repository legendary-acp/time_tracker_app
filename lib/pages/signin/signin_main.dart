import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/custom_widget/button.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:timetrackerapp/pages/signin/email_signin/email_signin.dart';
import 'package:timetrackerapp/pages/signin/signin_manger.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Signin extends StatelessWidget {
  const Signin({Key key, @required this.manager, @required this.isLoading}) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(
            auth: auth,
            isLoading: isLoading,
          ),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => Signin(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.cyan, Colors.indigo],
      )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            isLoading
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
              onpress: isLoading ? null : () => _signInWithGoogle(context),
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
              onpress: isLoading ? null : () => _signInWithFacebook(context),
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
              onpress: isLoading ? null : () => _signInWithEmail(context),
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
              onpress: isLoading ? null : () => _signInAnonymously(context),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: GradientAppBar(
        title: Text('Time Tracker'),
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
        centerTitle: true,
      ),
      body: _loginBuild(context),
    );
  }
}
