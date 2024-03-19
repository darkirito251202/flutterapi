import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_application_1/searchpage.dart';
import 'package:flutter_application_1/customappbar.dart';
import 'package:flutter_application_1/tomesenpossesion.dart';

class HomePage extends StatelessWidget {
  final String? email;
  static const String routeName = '/home';

  HomePage({required this.email});

  void handleLogout(BuildContext context) {
    // Code pour la déconnexion, par exemple, navigation vers la page de connexion
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(email: email, onLogout: () => handleLogout(context)),
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
              child: Text('Connexion'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SignupPage.routeName);
              },
              child: Text('Inscription'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SearchPage.routeName);
              },
              child: Text('Recherche'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(TomeEnPossessionPage.routeName);
              },
              child: Text('tomeposede'),
            ),
          ],
        ),
      ),
    );
  }
}
