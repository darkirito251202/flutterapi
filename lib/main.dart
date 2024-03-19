import 'package:flutter/material.dart';

import 'package:flutter_application_1/myhomepage.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/tomesenpossesion.dart';
import 'package:flutter_application_1/customappbar.dart';
import 'package:flutter_application_1/searchpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String? email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(email: email),
      routes: {
        '/home': (ctx) => HomePage(email: email),
        LoginPage.routeName: (ctx) => LoginPage(),
        SignupPage.routeName: (ctx) => SignupPage(),
        '/Login': (ctx) => LoginPage(),
        SearchPage.routeName: (context) => SearchPage(),
        TomeEnPossessionPage.routeName: (context) => TomeEnPossessionPage(),
      },
    );
  }
}
