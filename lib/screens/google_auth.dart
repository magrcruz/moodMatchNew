import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Auth'),
      ),
      body: Center(
        child: buildGoogleSignInButton(context),
      ),
    );
  }

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
  }

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
