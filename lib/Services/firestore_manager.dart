import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/SingletonUser.dart';

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

Future<void> savePreRegister(String username, String urlProfileImage) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userData = {
        'username': username,
        'profile_image': urlProfileImage,
        'email': user.email,
        'name': '',
        'last_name': '',
        'age': 0,
        'premium':false
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(userData);
    }
  } catch (error) {
    print('Error al registrar el usuario: $error');
  }
}

Future<void> fetchAndSetUserData(String uid) async {
  DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();
  print(userSnapshot);
  UserSingleton userSingleton = UserSingleton();
  userSingleton.username = userSnapshot['username'];
  userSingleton.profileImageUrl = userSnapshot['profile_image'];
  userSingleton.isPremium = userSnapshot['premium'];
  // userSingleton.isPremium = userSnapshot['isPremium'];
  // // Asumiendo que songGenres es un array de booleanos almacenado en Firestore
  // List<dynamic> songGenres = userSnapshot['songGenres'];
  // userSingleton.songGenres = songGenres.cast<bool>();
}
