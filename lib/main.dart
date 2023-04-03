import 'package:flutter/material.dart';
import 'package:flutter_application_1/myhomepage.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
        SignupPage.routeName: (ctx) => SignupPage(),
        HomePage.routeName: (ctx) => HomePage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay the splash screen for 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the home page
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
