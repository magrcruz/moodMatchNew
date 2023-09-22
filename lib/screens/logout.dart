import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('signOut test'),
      ),
      body: Center(
        child: buildSignOutButton(context),
      ),
    );
  }

  Widget buildSignOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              signOut(context);
            },
            child: const Text('signOut'),
          ),
        ],
      ),
    );
  }

  signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      if(context.mounted){
        Navigator.pushNamedAndRemoveUntil(context, '/google_auth', (route) => false);
      }
    } catch (error) {
      print('Error al cerrar sesión: $error');
    }
  }
}
