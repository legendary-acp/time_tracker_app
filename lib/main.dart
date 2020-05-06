import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/landing_page.dart';
import 'package:timetrackerapp/pages/login.dart';
import 'package:timetrackerapp/pages/home.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.indigo,
  ),
  debugShowCheckedModeBanner: false,
  home: Landing(),
));

