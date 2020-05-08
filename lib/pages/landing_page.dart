import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/home.dart';
import 'package:timetrackerapp/pages/login.dart';
import 'package:timetrackerapp/services/auth.dart';

class Landing extends StatelessWidget {
  Landing({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return Login(
              auth: auth,
            );
          } else {
            return Home(
              auth: auth,
            );
          }
        }
        else{
          return Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }
      }
    );
  }
}
