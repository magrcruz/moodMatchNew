import 'package:flutter/material.dart';
import 'package:mood_match/widgets/genre_title.dart';
import 'package:mood_match/main.dart';

class GenremusicPreferences extends StatefulWidget {
  @override
  _GenrePreferencesState createState() => _GenrePreferencesState();
}

class _GenrePreferencesState extends State<GenremusicPreferences> {
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

  List<String> selectedGenresMusic = [];

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
              'Géneros de Música',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Tres columnas
                    childAspectRatio: 1.2, // Asegura que los elementos tengan una relación de aspecto adecuada
                  ),
                  itemCount: allGenres.length,
                  itemBuilder: (context, index) {
                    final genre = allGenres[index];
                    return GestureDetector(
                      onTap: () => toggleGenreSelection(genre),
                      child: Card(
                        color: selectedGenresMusic.contains(genre) ? MyApp.customSwatch : Colors.white,
                        elevation: 3, // Sombra de la tarjeta
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Bordes redondeados de la tarjeta
                          side: BorderSide(
                            color: selectedGenresMusic.contains(genre) ? Colors.transparent : Colors.grey[300]!,
                            width: 1, // Ancho del borde de la tarjeta
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            // Icono de nota musical
                            Icon(
                              Icons.music_note,
                              color: selectedGenresMusic.contains(genre) ? Colors.white : Colors.black,
                              size: 40, // Tamaño del icono de nota musical
                            ),
                            // Texto del género
                            Positioned(
                              bottom: 10, // Ajusta la posición vertical del texto
                              child: Text(
                                genre,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedGenresMusic.contains(genre) ? Colors.white : Colors.black,
                                  fontWeight: selectedGenresMusic.contains(genre) ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                // Mostrar el número de géneros seleccionados
                final count = selectedGenresMusic.length;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Géneros seleccionados ($count)', textAlign: TextAlign.center,),
                      content: Text(selectedGenresMusic.join(', ')),
                      actions: [
                        TextButton(
                          child: const Text('Siguiente'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, '/genremoviesseries_preferences');
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Seleccionar (${selectedGenresMusic.length})'),
              style: TextButton.styleFrom(
                backgroundColor: MyApp.customSwatch,
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
      ].where((genre) => genre.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void toggleGenreSelection(String genre) {
    setState(() {
      if (selectedGenresMusic.contains(genre)) {
        selectedGenresMusic.remove(genre);
      } else {
        selectedGenresMusic.add(genre);
      }
    });
  }
}
