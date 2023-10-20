import 'package:flutter/material.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/firestore_manager.dart';
import '../Services/login_google.dart';
class GoogleAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MOOD MATCH'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo de Mood Match y texto
            Column(
              children: <Widget>[
                const Text(
                  'Inicia Sesión ',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 5),
                const Text(
                  'con Google',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 16),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  //NetworkImage(currentUser.profileImageURL),
                  radius: 100,
                ),
                const SizedBox(height: 16),
                Text(
                  'Sintonizando tus emociones',
                  style: GoogleFonts.shadowsIntoLight(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .displayLarge,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Botón de inicio de sesión de Google
            ElevatedButton.icon(
              onPressed: () async {
                String? uid = await signInWithGoogle();
                if (uid != null) {
                  bool isUserRegistered = await checkIfUserIsRegistered(uid);
                  if (isUserRegistered) {
                    await fetchAndSetUserData(uid);
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/pre_register');
                    }
                  }
                } else {
                  //Navegar a screen de error
                }
              },
              icon: Image.asset(
                'assets/images/google_logo.png',
                // Ruta de la imagen del logo de Google
                width: 24, // Ajusta el ancho según tus necesidades
                height: 24, // Ajusta la altura según tus necesidades
              ),
              label: Text('Iniciar sesión con Google'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Color de fondo blanco
                onPrimary: Colors.black, // Color del texto negro
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // Ajusta el radio de borde según tus necesidades
                  side: BorderSide(color: Colors.black), // Borde negro
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}