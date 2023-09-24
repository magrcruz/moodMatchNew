import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/user_profile.dart';

class HomeScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    UserProfile currentUser = UserProfile(
      username: user?.email ?? "Hola",
      profileImageURL: 'https://images.milenio.com/PBYshjJo2dc007elHCdKpZdoqW8=/375x0/uploads/media/2023/08/31/pantalon-para-tiendas.jpeg',//Dejo de funcionar, se vencio el link
      isPremium: true,
      name: 'namesito'
    );



    int numberOfRecommendations = 10;
    String lastRecommendation = "The Big Bang Theory";

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),//NetworkImage(currentUser.profileImageURL),
              radius: 100,
            ),
            const SizedBox(height: 20),
            Text(
              currentUser.username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Recomendaciones Hechas:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$numberOfRecommendations',
                      style: const TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Última Recomendación:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$lastRecommendation',
                      style: const TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/choose_content');
              },
              child: const Text(
                'Comencemos',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
