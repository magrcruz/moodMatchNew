import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Ir a Home'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/choose_emotion/default');
              },
              child: Text('Ir a ChooseEmotion DOESNT WORK'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/recommendation_results/default/default');
              },
              child: Text('Ir a RecommendationResults DOESNT WORK'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/choose_content');
              },
              child: Text('Ir a ChooseContent'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/genre_preferences');
              },
              child: Text('Ir a GenrePreferences'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/show_info');
              },
              child: Text('Ir a ShowInfo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/working');
              },
              child: Text('Ir a Working'),
            ),
          ],
        ),
      ),
    );
  }
}
