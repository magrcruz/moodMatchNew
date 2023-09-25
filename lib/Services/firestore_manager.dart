import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

Future<void> savePreRegister(String username, String urlProfileImage) async{
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