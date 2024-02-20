import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'myhomepage.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Send login request to API
      login(_emailController.text, _passwordController.text).then((userEmail) {
        if (userEmail != null) {
          setState(() {
            userEmail = userEmail;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Connexion réussie'),
          ));

          print('Navigating to MyHomePage with User Email: $userEmail');
          // Connexion réussie, redirigez vers la page d'accueil
          Navigator.pushReplacementNamed(context, HomePage.routeName,
              arguments: userEmail);
        } else {
          // Affichez un message d'erreur en cas d'échec de la connexion
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Échec de la connexion. Veuillez réessayer.'),
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('connection'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Adresse e-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une adresse e-mail valide';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> login(String email, String password) async {
    final apiUrl = Uri.parse(
        'http://s3-4443.nuage-peda.fr/api/public/api/authentication_token');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});
    final response = await http.post(apiUrl, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String email = data['email'];
      return data['email'];
    } else {}
    return http.post(apiUrl, headers: headers, body: body);
  }
}
