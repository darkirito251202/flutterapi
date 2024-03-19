import 'package:flutter/material.dart';
import 'package:flutter_application_1/tome.dart'; // Importer le modèle de Tome
import 'dart:convert';
import 'package:http/http.dart' as http;

class TomeEnPossessionPage extends StatefulWidget {
  static const routeName = '/TomeEnPossession';
  @override
  _TomeEnPossessionPageState createState() => _TomeEnPossessionPageState();
}

class _TomeEnPossessionPageState extends State<TomeEnPossessionPage> {
  late Future<List<Tome>> _tomesFuture;

  @override
  void initState() {
    super.initState();
    _tomesFuture =
        fetchTomesEnPossession(); // Appeler la fonction pour récupérer les tomes en possession
  }

  Future<List<Tome>> fetchTomesEnPossession() async {
    final response = await http.get(
      Uri.parse(
          'http://s3-4443.nuage-peda.fr/api/public/api/tomes'), // Modifier l'URL selon votre API
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Tome> tomes = data.map((json) => Tome.fromJson(json)).toList();
      // Filtrer les tomes en possession
      final List<Tome> tomesEnPossession =
          tomes.where((tome) => tome.enPossession).toList();
      return tomesEnPossession;
    } else {
      throw Exception(
          'Erreur lors de la récupération des données depuis l\'API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomes en possession'),
      ),
      body: FutureBuilder<List<Tome>>(
        future: _tomesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun tome en possession'));
          } else {
            final List<Tome> tomesEnPossession = snapshot.data!;
            return ListView.builder(
              itemCount: tomesEnPossession.length,
              itemBuilder: (context, index) {
                final Tome tome = tomesEnPossession[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Tome ${tome.numTome}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nombre de pages: ${tome.nbPage}'),
                        Text('Prix: ${tome.prix}'),
                        Text(
                            'Date de parution: ${tome.dateParution.toString()}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
