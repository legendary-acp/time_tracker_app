import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/pages/home/home_page.dart';
import 'package:timetrackerapp/pages/signin/signin_main.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/services/database.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return Signin.create(context);
            } else {
              return Provider<User>.value(
                value: user,
                child: Provider<Database>(
                    create: (_) => FirestoreDatabase(uid: user.uid),
                    child: HomePage()),
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
