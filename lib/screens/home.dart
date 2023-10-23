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
  String lastRecommendation = "Cargando..."; // Inicializa lastRecommendation

  @override
  _HomeScreenState createState() => _HomeScreenState();

  // Función para obtener la última recomendación
  Future<void> bob() async {
    String recomendacion = await obtenerUltimaRecomendacion(); // Llama a la función para obtener la recomendación

    if (recomendacion.isNotEmpty) {
      // Si se obtiene una recomendación válida, actualiza el estado
      setState(() {
        var widget;
        widget.lastRecommendation = recomendacion;
      });
    } else {
      // Maneja el caso en el que no se obtiene una recomendación válida
      setState(() {
        var widget;
        widget.lastRecommendation = "No hay recomendaciones disponibles";
      });
    }
  }
}

void setState(Null Function() param0) {
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Llama a la función para obtener la última recomendación cuando se inicia la pantalla
    widget.bob();
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
                        'Cargando...',
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
                        widget.lastRecommendation,
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
  }
}
