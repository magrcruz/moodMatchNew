import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mood_match/models/user_profile.dart';

class UserInfoController {
  final CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

  Future<UserProfile?> getUserProfileByEmail(String email) async {
    try {
      final DocumentSnapshot userDoc = await users.doc(email).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;

        final String username = data['usuario'] ?? '';
        final String profileImageURL = 'assets/images/logo.png'; // Reemplaza con la URL real de la imagen de perfil si la tienes en la base de datos
        final bool isPremium = data['isPremium'] ?? false; // Asegúrate de que coincida con el nombre del campo en tu base de datos
        final String name = data['nombres'] ?? '';

        return UserProfile(
          username: username,
          profileImageURL: profileImageURL,
          isPremium: isPremium,
          name: name,
        );
      } else {
        return null; // El usuario no existe en la base de datos
      }
    } catch (e) {
      print('Error al obtener la información del usuario: $e');
      throw e; // Puedes manejar errores o excepciones aquí según tus necesidades.
    }
  }
}
