import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/SingletonUser.dart';
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
  QuerySnapshot musicSnapshot =
  await FirebaseFirestore.instance.collection('song_gens').get();

  List<SongGenres> songGenresList = [];
  for (var document in musicSnapshot.docs) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    SongGenres songGen = SongGenres.fromMap(data);
    songGenresList.add(songGen);
  }
  return songGenresList;
}
