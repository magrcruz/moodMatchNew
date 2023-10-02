import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/user_profile.dart';
import 'package:mood_match/controllers/emotionClasification.dart';
class HomeScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String userImageURL = user?.photoURL ?? 'assets/images/logo.png'; // URL de imagen de usuario o imagen de respaldo

    UserProfile currentUser = UserProfile(
      username: user?.displayName ?? "Usuario",
      profileImageURL: userImageURL, // Asigna la URL de la imagen
      isPremium: true,
      name: 'namesito',
    );

    int numberOfRecommendations = 10;
    String lastRecommendation = "The Big Bang Theory";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            CircleAvatar(
              backgroundImage: NetworkImage(userImageURL), // Carga la imagen desde la URL
              radius: 50,
            ),
            SizedBox(height: 20),
            Text(
              '¡Hola!',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Text(
              currentUser.username,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(15),
                  elevation: 5,
                  shadowColor: Colors.black,
                  child: SizedBox(
                    width: 250,
                    height: 80,
                    child: ListTile(
                      title: const Text(
                        'Recomendaciones',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        '$numberOfRecommendations',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(15),
                  elevation: 5,
                  shadowColor: Colors.black,
                  child: SizedBox(
                    width: 250,
                    height: 80,
                    child: ListTile(
                      title: const Text(
                        'Última Recomendación:',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        lastRecommendation,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/choose_content');
              },
              child: const Text(
                '¿Comenzamos?',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
