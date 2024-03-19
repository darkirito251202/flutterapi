import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:http/http.dart' as http;

class Test {
  static Future<http.Response> registerUser(
      String email, String password, String nom, String prenom) async {
    final apiUrl =
        Uri.parse("https://s3-4443.nuage-peda.fr/api/public/api/users");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(
        {'email': email, 'password': password, 'nom': nom, 'prenom': prenom});

    return await http.post(apiUrl, headers: headers, body: body);
  }
}

void main() {
  group('Registration Test', () {
    test('Register User', () async {
      final email = "test@example.com";
      final password = "password";
      final nom = "Nom";
      final prenom = "Prénom";

      final response = await Test.registerUser(email, password, nom, prenom);

      // Vérifier que le code de statut de l'API est 200
      expect(response.statusCode, equals(200));

      // Vérifier que les données sont correctement enregistrées en vérifiant le contenu de la réponse
      var responseData = json.decode(response.body);
      expect(responseData['email'], equals(email));
      // Ajoutez d'autres vérifications si nécessaire
    });
  });
}
