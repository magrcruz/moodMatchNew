import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_match/models/SingletonUser.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/user_profile.dart';

class HomeScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProfile currentUser = UserProfile(
      username:
          UserSingleton().username != "" ? UserSingleton().username : "Usuario",
      profileImageURL: UserSingleton().profileImageUrl != ""
          ? UserSingleton().profileImageUrl
          : 'assets/images/logo.png', // Asigna la URL de la imagen
      isPremium: UserSingleton().premium,
      name: UserSingleton().name,
    );

    int numberOfRecommendations = 10; //Por ahora no
    String lastRecommendation = "The Big Bang Theory"; //Por ahora no

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            CircleAvatar(
              backgroundImage: NetworkImage(currentUser.profileImageURL),
              radius: 50,
            ),
            const SizedBox(height: 20),
            const Text(
              '¡Hola!',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Text(
              currentUser.username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
                        style: TextStyle(
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
                        style: TextStyle(
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
