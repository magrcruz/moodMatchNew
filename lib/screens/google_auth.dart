import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
class GoogleAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo de Mood Match y texto
            Column(
              children: <Widget>[
                Text(
                  'Inicia Sesión ',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 5), // Espacio entre el texto y el logo ,
                Text(
                  'con Google',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 16), // Espacio entre el texto y el logo ,
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),//NetworkImage(currentUser.profileImageURL),
                  radius: 100,
                ),
                SizedBox(height: 16), // Espacio entre el texto y el logo ,
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

            SizedBox(height: 20),

            // Botón de inicio de sesión de Google
            ElevatedButton.icon(
              onPressed: () {
                signInWithGoogle(context);
              },
              icon: Image.asset(
                'assets/images/google_logo.png', // Ruta de la imagen del logo de Google
                width: 24, // Ajusta el ancho según tus necesidades
                height: 24, // Ajusta la altura según tus necesidades
              ),
              label: Text('Iniciar sesión con Google'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Color de fondo blanco
                onPrimary: Colors.black, // Color del texto negro
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Ajusta el radio de borde según tus necesidades
                  side: BorderSide(color: Colors.black), // Borde negro
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
/*
  Widget buildGoogleSignInButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              signInWithGoogle(context);
            },
            child: const Text('Login with Google'),
          ),
        ],
      ),
    );
    */



  signInWithGoogle(BuildContext context) async {
    final currentContext = context;

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user != null) {
      bool isUserRegistered = await checkIfUserIsRegistered(user.uid);

      if (isUserRegistered) {
        if(context.mounted){
          Navigator.pushReplacementNamed(currentContext, '/home');
        }
      } else {
        if(context.mounted){
          Navigator.pushReplacementNamed(currentContext, '/register');
        }
      }
    }
  }

  Future<bool> checkIfUserIsRegistered(String uid) async {
    try {
      final DocumentSnapshot document =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      return document.exists;
    } catch (error) {
      print('Firestore Error: $error');
      return false;
    }
  }
}
