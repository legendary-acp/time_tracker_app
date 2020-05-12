import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/landing_page.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
        home: Landing(),
      ),
    ));
