import 'package:flutter/material.dart';

class GenrePreferences extends StatefulWidget {
  @override
  _GenrePreferencesState createState() => _GenrePreferencesState();
}

class _GenrePreferencesState extends State<GenrePreferences> {
  List<String> allGenres = [
    'Pop',
    'Rock',
    'Hip Hop',
    'Jazz',
    'Electronic',
    'Classical',
    'Country',
    'R&B',
    'Reggae',
  ];

  List<String> displayedGenres = [];

  @override
  void initState() {
    super.initState();
    displayedGenres.addAll(allGenres);
  }

  void filterGenres(String query) {
    setState(() {
      displayedGenres = allGenres
          .where((genre) => genre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias de Género Musical'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => filterGenres(query),
              decoration: InputDecoration(
                labelText: 'Buscar género',
                hintText: 'Escribe aquí...',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedGenres.length,
              itemBuilder: (context, index) {
                final genre = displayedGenres[index];
                return GenreTile(genre: genre);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GenreTile extends StatelessWidget {
  final String genre;

  GenreTile({required this.genre});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(genre),
      // Aquí puedes agregar lógica adicional para manejar la selección del género
    );
  }
}
