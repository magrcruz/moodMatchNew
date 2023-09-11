import 'package:flutter/material.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/user_profile.dart'; // Importa la clase UserProfile o la estructura de datos del usuario

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Supongamos que tienes una instancia de UserProfile llamada currentUser
    UserProfile currentUser = UserProfile(
      username: 'Usuario Predeterminado',
      profileImageURL: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              // Muestra la foto de perfil del usuario
              backgroundImage: NetworkImage(currentUser.profileImageURL), // Reemplaza con la URL de la foto de perfil
              radius: 50, // Ajusta el tamaño de la foto de perfil según tus preferencias
            ),
            SizedBox(height: 20),
            Text(
              // Muestra el nombre de usuario del usuario
              currentUser.username,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              '¡Bienvenido a nuestra aplicación!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/index');
              },
              child: Text('Comencemos'),
            ),
          ],
        ),
      ),
    );
  }
}
