import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/firestore_manager.dart';
import '../Services/login_google.dart';

class LoginGoogle extends StatelessWidget {
  const LoginGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOOD MATCH'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo de Mood Match y texto
            Column(
              children: <Widget>[
                const Text(
                  'Inicia Sesión',
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
                    textStyle: Theme.of(context).textTheme.displayLarge,
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
                width: 24,
                height: 24,
              ),
              label: const Text('Iniciar sesión con Google'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
