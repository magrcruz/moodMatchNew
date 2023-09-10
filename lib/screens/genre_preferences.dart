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
    // Agrega más géneros según tus necesidades
  ];

  List<String> selectedGenres = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tus géneros favoritos'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) => filterGenres(query),
              decoration: InputDecoration(
                labelText: 'Buscar género',
                hintText: 'Escribe aquí...',
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Dos columnas
              ),
              itemCount: allGenres.length,
              itemBuilder: (context, index) {
                final genre = allGenres[index];
                return GenreTile(
                  genre: genre,
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
                          child: Text('Cerrar'),
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

class GenreTile extends StatelessWidget {
  final String genre;
  final bool isSelected;
  final void Function(bool)? onSelected; // Corregir la firma de onSelected

  GenreTile({
    required this.genre,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onSelected != null) {
          onSelected!(!isSelected);
        }
      },
      child: Card(
        color: isSelected ? Colors.blue : Colors.white,
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Aquí puedes agregar la imagen correspondiente a cada género
            Text(genre),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: GenrePreferences(),
    ));
