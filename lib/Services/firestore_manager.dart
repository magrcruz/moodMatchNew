import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_match/models/SongPlatforms.dart';
import 'dart:math';

import '../models/SingletonUser.dart';
import '../models/Song.dart';
import '../models/SongGenres.dart';

Future<bool> checkIfUserIsRegistered(String uid) async {
  try {
    final DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return document.exists;
  } catch (error) {
    print('Firestore Error: $error');
    return false;
  }
}

Future<void> uploadUserData() async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Map<String, Object> userData = UserSingleton().getUserData();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(userData);
    }
  } catch (error) {
    UserSingleton().logOutUser();
    print('Error al registrar el usuario: $error');
  }
}

Future<void> fetchAndSetUserData(String uid) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
  UserSingleton().logInUser(data);
}

Future<List<SongGenres>> getSongGenresFirebase() async {
  QuerySnapshot songGenresSnapshot =
      await FirebaseFirestore.instance.collection('song_gens').get();

  List<SongGenres> songGenresList = [];
  for (var document in songGenresSnapshot.docs) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    SongGenres songGen = SongGenres.fromMap(data);
    songGenresList.add(songGen);
  }
  return songGenresList;
}

Future<List<SongPlatforms>> getSongPlatformsFirebase() async {
  QuerySnapshot songPlatformsSnapshot =
      await FirebaseFirestore.instance.collection('song_services').get();

  List<SongPlatforms> songPlatformsList = [];
  for (var document in songPlatformsSnapshot.docs) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    SongPlatforms songPlat = SongPlatforms.fromMap(data);
    songPlatformsList.add(songPlat);
  }
  return songPlatformsList;
}

Future<List<Song>> getSongsWithEmotion(int emotion) async {
  List<int> genres = [];
  for (int i = 0; i < UserSingleton().songGenres.length; i++) {
    if (UserSingleton().songGenres[i]) {
      genres.add(i);
    }
  }

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('songs')
      .where('emotion', isEqualTo: emotion)
      .where('genre', whereIn: genres)
      .get();

  List<DocumentSnapshot> songs = querySnapshot.docs;

  if (songs.length <= 5) {
    return songs.map((doc) => Song.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  final random = Random();
  final uniqueIndices = <int>{};
  while (uniqueIndices.length < 5) {
    uniqueIndices.add(random.nextInt(songs.length));
  }

  List<Song> randomSongs = uniqueIndices
      .map((index) => Song.fromMap(songs[index].data() as Map<String, dynamic>))
      .toList();

  return randomSongs;
}
