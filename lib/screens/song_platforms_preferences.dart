import 'package:flutter/material.dart';
import 'package:mood_match/models/SingletonUser.dart';

import '../Services/firestore_manager.dart';
import '../models/SongPlatforms.dart';

class SongPlatformsPreferences extends StatefulWidget {
  const SongPlatformsPreferences({super.key});

  @override
  State<SongPlatformsPreferences> createState() =>
      _SongPlatformsPreferencesState();
}

class _SongPlatformsPreferencesState extends State<SongPlatformsPreferences> {
  List<SongPlatforms> songPlatformsList = [];
  List<SongPlatforms> filteredPlatforms = [];
  Set<int> selectedPlatforms = <int>{};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSongPlatformsFirebase().then((platforms) {
      setState(() {
        songPlatformsList = platforms;
        filteredPlatforms = platforms;
        isLoading = false;
      });
    });
  }

  void _filterPlatforms(String query) {
    if (!isLoading) {
      setState(() {
        filteredPlatforms = songPlatformsList
            .where((genre) =>
                genre.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _togglePlatformSelection(int pk) {
    setState(() {
      if (selectedPlatforms.contains(pk)) {
        selectedPlatforms.remove(pk);
      } else {
        selectedPlatforms.add(pk);
      }
    });
  }

  void saveSongPlatforms() {
    List<dynamic> platforms =
        List.generate(UserSingleton().songServices.length, (index) => false);
    for (int i in selectedPlatforms) {
      platforms[i] = true;
    }
    UserSingleton().songServices = platforms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plataformas de Canciones'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: _filterPlatforms,
              decoration: const InputDecoration(
                labelText: 'Buscar plataforma',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredPlatforms.isEmpty
                    ? const Center(child: Text('No se encontraron resultados'))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: filteredPlatforms.length,
                        itemBuilder: (context, index) {
                          final genre = filteredPlatforms[index];
                          final isSelected =
                              selectedPlatforms.contains(genre.pk);
                          return InkWell(
                            onTap: () {
                              _togglePlatformSelection(genre.pk);
                            },
                            child: GenreCard(genre, isSelected),
                          );
                        },
                      ),
          ),
          ElevatedButton(
            onPressed: () {
              saveSongPlatforms();
              uploadUserData();
              if (context.mounted) {
                Navigator.pushReplacementNamed(
                    context, '/home');
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
  final SongPlatforms genre;
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
            backgroundImage: NetworkImage(genre.logo),
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
