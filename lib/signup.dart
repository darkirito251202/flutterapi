import 'package:flutter/material.dart';
import 'package:flutter_application_1/myhomepage.dart';

class SignupPage extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Perform sign up and navigate to the home page
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          },
          child: Text('Sign up'),
        ),
      ),
    );
  }
}
