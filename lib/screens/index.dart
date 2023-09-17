import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Ir a Home'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('SignUp'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/choose_emotion');
              },
              child: const Text('Ir a ChooseEmotion'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/recommendation_results/default/default');
              },
              child: const Text('Ir a RecommendationResults'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/choose_content');
              },
              child: const Text('Ir a ChooseContent'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/genre_preferences');
              },
              child: const Text('Ir a GenrePreferences'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/show_info');
              },
              child: const Text('Ir a ShowInfo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user_info');
              },
              child: const Text('Ir a UserInfo'),
            ),
          ],
        ),
      ),
    );
  }
}
