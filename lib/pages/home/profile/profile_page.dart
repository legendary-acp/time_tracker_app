
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/custom_widget/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/auth.dart';

class ProfilePage extends StatefulWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print('This is error ${e.toString()}s');
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Sign Out',
      content: 'Are you sure you want to sign out?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut) {
      _signOut(context);
    }
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => widget._confirmSignOut(context),
          ),
        ],
      ),
    );
  }
}
