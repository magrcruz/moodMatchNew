import 'package:flutter/material.dart';
import 'package:mood_match/widgets/genre_title.dart';
import 'package:mood_match/main.dart';
import 'package:mood_match/controllers/genresClassification.dart';
class GenremovieseriePreferences extends StatefulWidget {
  @override
  _GenrePreferencesState createState() => _GenrePreferencesState();
}
List<String> fillGenres() {
  List<String> fillalllgenres = [];
  for (var elemento in genres) {
    if (elemento is Map<String, dynamic> && elemento.containsKey("name")) {
      var nombre = elemento["name"];
      if (nombre is String) {
        fillalllgenres.add(nombre);
      }
    }
  }
  return fillalllgenres;
}
class _GenrePreferencesState extends State<GenremovieseriePreferences> {
  List<String> allGenres = fillGenres();

  List<String> selectedGenresMovies = [];

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
              'Géneros de Películas y Series',
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
                      allGenres = fillGenres();
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Tres columnas
                  childAspectRatio: 1.2, // Asegura que los elementos tengan una relación de aspecto adecuada
                ),
                itemCount: allGenres.length,
                itemBuilder: (context, index) {
                  final genre = allGenres[index];
                  return GestureDetector(
                    onTap: () => toggleGenreSelection(genre),
                    child: Card(
                      color: selectedGenresMovies.contains(genre) ? MyApp.customSwatch : Colors.white,
                      elevation: 3, // Sombra de la tarjeta
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Bordes redondeados de la tarjeta
                        side: BorderSide(
                          color: selectedGenresMovies.contains(genre) ? Colors.transparent : Colors.grey[300]!,
                          width: 1, // Ancho del borde de la tarjeta
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          // Icono de película
                          Icon(
                            Icons.movie,
                            color: selectedGenresMovies.contains(genre) ? Colors.white : Colors.black,
                            size: 20, // Tamaño del icono de película
                          ),
                          // Texto del género
                          Positioned(
                            bottom: 10, // Ajusta la posición vertical del texto
                            child: Text(
                              genre,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: selectedGenresMovies.contains(genre) ? Colors.white : Colors.black,
                                fontWeight: selectedGenresMovies.contains(genre) ? FontWeight.bold : FontWeight.normal,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                // Mostrar el número de géneros seleccionados
                final count = selectedGenresMovies.length;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Géneros seleccionados ($count)',textAlign: TextAlign.center,),
                      content: Text(selectedGenresMovies.join(', ')),
                      actions: [
                        TextButton(
                          child: const Text('Siguiente'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, '/platforms_preferences');
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Seleccionar (${selectedGenresMovies.length})'),
              style: TextButton.styleFrom(
                backgroundColor:MyApp.customSwatch,
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
      if (selectedGenresMovies.contains(genre)) {
        selectedGenresMovies.remove(genre);
      } else {
        selectedGenresMovies.add(genre);
      }
    });
  }
}
