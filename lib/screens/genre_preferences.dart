import 'package:flutter/material.dart';
import 'package:mood_match/widgets/genre_title.dart';

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
    // Agrega más géneros según tus necesidades
  ];

  List<String> selectedGenres = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias'),
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            title: Text(
              'Selecciona los géneros de tu preferencia',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) => filterGenres(query),
              decoration: InputDecoration(
                labelText: 'Buscar género',
                hintText: 'Escribe aquí...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear), // Icono para borrar el texto
                  onPressed: () {
                    searchController.clear(); // Borra el texto de búsqueda
                    // Restablece la lista de géneros a su estado original
                    setState(() {
                      allGenres = [
                        'Pop',
                        'Rock',
                        'Hip Hop',
                        'Jazz',
                        'Electronic',
                        'Classical',
                        'Country',
                        'R&B',
                        'Reggae',
                        // Agrega más géneros según tus necesidades
                      ];
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Tres columnas
                childAspectRatio: 1.0, // Asegura que los elementos sean cuadrados
              ),
              itemCount: allGenres.length,
              itemBuilder: (context, index) {
                final genre = allGenres[index];
                final type = "music";
                return GenreTile(
                  genre: genre,
                  type: type,
                  isSelected: selectedGenres.contains(genre),
                  onSelected: (isSelected) => toggleGenreSelection(genre),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                // Mostrar el número de géneros seleccionados
                final count = selectedGenres.length;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Géneros seleccionados ($count)'),
                      content: Text(selectedGenres.join(', ')),
                      actions: [
                        TextButton(
                          child: const Text('Cerrar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Seleccionar (${selectedGenres.length})'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                primary: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void filterGenres(String query) {
    setState(() {
      allGenres = allGenres
          .where((genre) =>
              genre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleGenreSelection(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }
}
