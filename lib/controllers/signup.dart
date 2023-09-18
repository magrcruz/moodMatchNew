import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController {
  final CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

  Future<bool> signUp(String email, String password, String firstName, String lastName, String username) async {
    try {
      // Verificar si el usuario ya existe
      DocumentSnapshot userDoc = await users.doc(email).get();

      if (userDoc.exists) {
        return false; // El usuario ya existe
      }

      // Crear un nuevo documento de usuario
      await users.doc(email).set({
        'correo': email,
        'contrasena': password,
        'nombres': firstName,
        'apellidos': lastName,
        'usuario': username,
      });

      return true; // Registro exitoso
    } catch (e) {
      print('Error al registrar el usuario: $e');
      return false; // Registro fallido
    }
  }
}
