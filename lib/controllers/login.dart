import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> loginUser(String email, String password) async {
  try {
    // Accede a la colección de usuarios en Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

    // Consulta Firestore para encontrar un usuario con el correo electrónico proporcionado
    QuerySnapshot querySnapshot = await users.where('Correo', isEqualTo: email).get();

    if (querySnapshot.size == 0) {
      // El usuario no existe en la base de datos
      return false;
    } else {
      // Usuario encontrado, ahora verifica la contraseña
      var userDoc = querySnapshot.docs[0];
      if (userDoc['Contrasena'] == password) {
        // La contraseña coincide, el usuario está autenticado con éxito
        return true;
      } else {
        // La contraseña no coincide
        return false;
      }
    }
  } catch (e) {
    print('Error al iniciar sesión: $e');
    return false;
  }
}

Future<void> printAvailableEmails() async {
  try {
    // Accede a la colección de usuarios en Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

    // Consulta Firestore para obtener todos los correos disponibles
    QuerySnapshot querySnapshot = await users.get();

    print('Correos disponibles:');
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      print(doc['Correo']);
    }
  } catch (e) {
    print('Error al obtener correos disponibles: $e');
  }
}
