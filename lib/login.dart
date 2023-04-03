import 'package:flutter/material.dart';
import 'package:flutter_application_1/myhomepage.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Perform login and navigate to the home page
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
