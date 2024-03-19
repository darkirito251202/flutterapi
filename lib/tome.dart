import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tome {
  final int id;
  final int numTome;
  final int nbPage;
  final int prix;
  final DateTime dateParution;
  bool enPossession;

  Tome({
    required this.id,
    required this.numTome,
    required this.nbPage,
    required this.prix,
    required this.dateParution,
    required this.enPossession,
  });

  Future<void> togglePossession() async {
    final response = await http.post(
      Uri.parse(
        'http://s3-4443.nuage-peda.fr/api/public/api/tomes/${this.id}/toggle-posede',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      enPossession = !enPossession;
    } else {
      print('Échec de la mise à jour du statut de possession');
      print(response.body);
    }
  }

  factory Tome.fromJson(Map<String, dynamic> json) {
    return Tome(
      id: json['id'] as int,
      numTome: json['numtome'] as int,
      nbPage: json['nbpage'] as int,
      prix: json['prix'] as int,
      dateParution: DateTime.parse(json['dateparution']),
      enPossession: json['enPossession'] as bool? ?? false,
    );
  }
}

class TomePage extends StatefulWidget {
  final int mangaId;

  TomePage({required this.mangaId});

  @override
  _TomePageState createState() => _TomePageState();
}

class _TomePageState extends State<TomePage> {
  late List<Tome> _tomes;

  @override
  void initState() {
    super.initState();
    _tomes = []; // Initialisez _tomes avec une liste vide
    _fetchTomes(widget.mangaId);
  }

  Future<void> _fetchTomes(int mangaId) async {
    final response = await http.get(
      Uri.parse('http://s3-4443.nuage-peda.fr/api/public/api/tomes'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> tomesData = data['hydra:member'];
      setState(() {
        _tomes = tomesData.map((json) => Tome.fromJson(json)).toList();
      });
    } else {
      print(
          'Erreur lors de la récupération des données depuis l\'API : ${response.statusCode}');
      print(response.body);
      throw Exception(
          'Erreur lors de la récupération des données depuis l\'API');
    }
  }

  // Fonction pour rafraîchir l'interface utilisateur après la mise à jour de l'état de possession
  void _refreshUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomes du Manga'),
      ),
      body: _tomes != null
          ? _buildTomeList()
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildTomeList() {
    return ListView.builder(
      itemCount: _tomes.length,
      itemBuilder: (context, index) {
        final Tome tome = _tomes[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Tome ${tome.numTome}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre de pages: ${tome.nbPage}'),
                Text('Prix: ${tome.prix}'),
                Text('Date de parution: ${tome.dateParution.toString()}'),
                // Afficher le statut de possession
                Text('En possession: ${tome.enPossession ? 'Oui' : 'Non'}'),
              ],
            ),
            // Rendre la case clickable
            onTap: () {
              // Mettre à jour l'état de possession
              tome.togglePossession().then((_) {
                // Rafraîchir l'interface après la mise à jour
                _refreshUI();
              });
            },
            // Ajouter un bouton de sélection pour changer l'état de possession
            trailing: IconButton(
              icon: Icon(tome.enPossession
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onPressed: () {
                // Mettre à jour l'état de possession
                tome.togglePossession().then((_) {
                  // Rafraîchir l'interface après la mise à jour
                  _refreshUI();
                });
              },
            ),
          ),
        );
      },
    );
  }
}
