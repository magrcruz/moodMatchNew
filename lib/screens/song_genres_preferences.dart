import 'package:flutter/material.dart';
import 'package:mood_match/models/SingletonUser.dart';
import '../Services/firestore_manager.dart';
import '../models/SongGenres.dart';

class SongGenresPreferences extends StatefulWidget {
  const SongGenresPreferences({super.key});

  @override
  State<SongGenresPreferences> createState() => _SongGenresPreferencesState();
}

class _SongGenresPreferencesState extends State<SongGenresPreferences> {
  List<SongGenres> songGenresList = [];
  List<SongGenres> filteredGenres = [];
  Set<int> selectedGenres = <int>{};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSongGenresFirebase().then((genres) {
      setState(() {
        songGenresList = genres;
        filteredGenres = genres;
        isLoading = false;
      });
    });
  }

  void _filterGenres(String query) {
    if (!isLoading) {
      setState(() {
        filteredGenres = songGenresList
            .where((genre) =>
                genre.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _toggleGenreSelection(int pk) {
    setState(() {
      if (selectedGenres.contains(pk)) {
        selectedGenres.remove(pk);
      } else {
        selectedGenres.add(pk);
      }
    });
  }

  void saveSongGenres() {
    List<dynamic> genres =
        List.generate(UserSingleton().songGenres.length, (index) => false);
    for (int i in selectedGenres) {
      genres[i] = true;
    }
    UserSingleton().songGenres = genres;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Géneros de Canciones'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: _filterGenres,
              decoration: const InputDecoration(
                labelText: 'Buscar géneros',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredGenres.isEmpty
                    ? const Center(child: Text('No se encontraron resultados'))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: filteredGenres.length,
                        itemBuilder: (context, index) {
                          final genre = filteredGenres[index];
                          final isSelected = selectedGenres.contains(genre.pk);
                          return InkWell(
                            onTap: () {
                              _toggleGenreSelection(genre.pk);
                            },
                            child: GenreCard(genre, isSelected),
                          );
                        },
                      ),
          ),
          ElevatedButton(
            onPressed: () {
              saveSongGenres();
              if (context.mounted) {
                Navigator.pushReplacementNamed(
                    context, '/song_platforms_preferences');
              }
            },
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  final SongGenres genre;
  final bool isSelected;

  const GenreCard(this.genre, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: isSelected ? const Color(0xFFFF6F6F) : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(genre.image),
          ),
          const SizedBox(height: 5.0),
          Text(
            genre.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}