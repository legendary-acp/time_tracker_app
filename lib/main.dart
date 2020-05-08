import 'package:flutter/material.dart';
import 'package:timetrackerapp/pages/landing_page.dart';
import 'package:timetrackerapp/services/auth.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.indigo,
  ),
  debugShowCheckedModeBanner: false,
  home: Landing(
    auth: Auth(),
  ),
));

