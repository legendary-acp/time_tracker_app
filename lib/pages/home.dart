import 'package:flutter/material.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/services/auth.dart';

class Home extends StatefulWidget {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth=Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print('This is error ${e.toString()}s');
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Sign Out',
      content: 'Are you sure you want to signout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if(didRequestSignOut){
      _signOut(context);
    }
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return _HomeBuild();
  }

  // ignore: non_constant_identifier_names
  Widget _HomeBuild() {
    final auth=Provider.of<AuthBase>(context);
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
            onPressed: () => widget._confirmSignOut(context),
          )
        ],
        centerTitle: true,
      ),
      body: Text("${auth.currentUser()}"),
    );
  }
}
