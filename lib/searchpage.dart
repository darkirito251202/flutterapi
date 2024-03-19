import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/tome.dart';

class Manga {
  final int id;
  final String titre;
  final String editeur;
  final String type;
  final int nbvolumes;

  Manga({
    required this.id,
    required this.titre,
    required this.editeur,
    required this.type,
    required this.nbvolumes,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
      id: json['id'] as int,
      titre: json['titre'] as String? ?? '',
      editeur: json['editeur'] as String? ?? '',
      type: json['type'] as String? ?? '',
      nbvolumes: json['nbvolumes'] as int? ?? 0,
    );
  }
}

Future<List<Manga>> fetchData(String query) async {
  final response = await http.get(
    Uri.parse('http://s3-4443.nuage-peda.fr/api/public/api/mangas'),
  );

  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);

    if (data is Map<String, dynamic> && data.containsKey('hydra:member')) {
      final List<dynamic> members = data['hydra:member'];
      final List<Manga> mangas =
          members.map((json) => Manga.fromJson(json)).toList();
      final List<Manga> filteredResults = mangas
          .where((manga) =>
              manga.titre.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return filteredResults;
    } else {
      throw Exception('Format de réponse inattendu depuis l\'API');
    }
  } else {
    print(
        'Erreur lors de la récupération des données depuis l\'API : ${response.statusCode}');
    print(response.body);
    throw Exception('Erreur lors de la récupération des données depuis l\'API');
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Manga> _searchResults = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche manga'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un manga par titre...',
              ),
              onChanged: (query) {
                search(query);
              },
            ),
          ),
          isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: _searchResults.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final Manga manga = _searchResults[index];
                            return Card(
                              margin: EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Titre: ${manga.titre}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Editeur: ${manga.editeur}'),
                                    Text('Type: ${manga.type}'),
                                    Text('Nbvolumes: ${manga.nbvolumes}'),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TomePage(mangaId: manga.id),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text('Aucun résultat trouvé'),
                        ),
                ),
        ],
      ),
    );
  }

  Future<void> search(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {
        final results = await fetchData(query);
        setState(() {
          _searchResults = results;
          isLoading = false;
        });
      } catch (e) {
        print('Erreur de recherche : $e');
        setState(() {
          _searchResults = [];
          isLoading = false;
        });
      }
    } else {
      setState(() {
        _searchResults = [];
        isLoading = false;
      });
    }
  }
}

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchScreen(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}
