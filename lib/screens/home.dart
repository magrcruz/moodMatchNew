import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_match/controllers/recommendations.dart';
import 'package:mood_match/models/SingletonUser.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/user_profile.dart';
import 'package:mood_match/controllers/emotionClasification.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;
String? userUid = user?.uid;

class HomeScreen extends StatefulWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String lastRecommendation = ""; // Inicializa lastRecommendation
  num numeroRecomendaciones = 0; // Inicializa el número de recomendaciones

  @override
  void initState() {
    super.initState();
    //obtenerUltimaRecomendacionStream();
    obtenerNumeroRecomendacionesRestantes().then((numero) {
      setState(() {
        numeroRecomendaciones = numero;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String userImageURL = UserSingleton().profileImageUrl ?? 'assets/images/logo.png';

    UserProfile currentUser = UserProfile(
      username: UserSingleton().username ?? "Usuario",
      profileImageURL: userImageURL,
      isPremium: true,
      name: 'namesito',
    );

    return StreamBuilder<String>(
      stream: obtenerUltimaRecomendacionStream(), // Escucha cambios en la recomendación
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          lastRecommendation = snapshot.data ?? "";
        }

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
                  backgroundImage: NetworkImage(userImageURL),
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
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Text(
                            '$numeroRecomendaciones',
                            style: TextStyle(
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
                            style: TextStyle(fontSize: 16),
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
                  child: Text(
                    '¿Comenzamos?',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
