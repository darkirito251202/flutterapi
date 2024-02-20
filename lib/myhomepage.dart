import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/searchpage.dart';

import 'package:flutter_application_1/customappbar.dart';

class HomePage extends StatelessWidget {
  final String? email;
  static const String routeName = '/home';
  HomePage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(email: email),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(LoginPage.routeName);
              },
              child: Text('connection'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SignupPage.routeName);
              },
              child: Text('inscription'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
              ),
              onPressed: () {
                //Navigator.of(context).pushNamed(SearchPage.routeName);
              },
              child: Text('recherche'),
            ),
          ],
        ),
      ),
    );
  }
}
