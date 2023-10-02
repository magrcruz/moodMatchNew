import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<DocumentSnapshot> documentList = [];

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
                Navigator.pushNamed(context, '/home');
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
                Navigator.pushNamed(context, '/splash');
              },
              child: const Text('splash'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/splash2');
              },
              child: const Text('splash2'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/google_auth');
              },
              child: const Text('Login with Google'),
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
                Navigator.pushNamed(
                    context, '/recommendation_results/default/default');
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
                Navigator.pushNamed(context, '/genremusic_preferences');
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
                Navigator.pushNamed(context, '/signout');
              },
              child: const Text('Ir a signOut'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user_info');
              },
              child: const Text('Ir a UserInfo'),
            ),
            ElevatedButton(
              child: const Text('Texto del botón'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('mi-colección')
                    .doc()
                    .set({
                  'name': 'taichi',
                  'age': 23,
                  'sex': 'male',
                  'type': ['A', 'B']
                });
                setState(() {}); // Actualiza el estado
              },
            ),
            ElevatedButton(
              child: const Text('Texto del botón'),
              onPressed: () async {
                final snapshot = await FirebaseFirestore.instance
                    .collection('mi-colección')
                    .get();
                setState(() {
                  documentList = snapshot.docs;
                });
              },
            ),
            Column(
              children: documentList.map((document) {
                return ListTile(
                  title: Text('Nombre: ${document['name']}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
