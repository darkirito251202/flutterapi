import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/searchpage.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('accueil'),
      ),
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
              child: Text('Login'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SignupPage.routeName);
              },
              child: Text('Signup'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
              ),
              onPressed: () {
                //Navigator.of(context).pushNamed(SearchPage.routeName);
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
