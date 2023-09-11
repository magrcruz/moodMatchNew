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
        title: Text('Preferencias'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
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
                  icon: Icon(Icons.clear), // Icono para borrar el texto
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Tres columnas
                childAspectRatio: 1.0, // Asegura que los elementos sean cuadrados
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
  final void Function(bool)? onSelected;

  GenreTile({
    required this.genre,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = 'assets/images/defaultMovie.png';
    return InkWell(
      onTap: () {
        if (onSelected != null) {
          onSelected!(!isSelected);
        }
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Ajusta el radio de la tarjeta según tus necesidades.
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF9BD5C9), Color(0xFF86A8E7)],
                  )
                : null,
            borderRadius: BorderRadius.circular(12.0), // Ajusta el radio de la tarjeta según tus necesidades.
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0), // Ajusta el radio de las esquinas de la imagen.
                child: Image.asset(
                  imagePath,
                  width: 80, // Ajusta el tamaño de la imagen según tus necesidades.
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    // En caso de error al cargar la imagen, muestra la imagen por defecto.
                    return Image.asset(
                      'assets/images/defaultMovie.png',
                      width: 80,
                      height: 80,
                    );
                  },
                ),
              ),
              SizedBox(height: 5), // Espacio entre la imagen y el texto
              Text(
                genre,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'system-ui', // Cambia la fuente a system ui
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
