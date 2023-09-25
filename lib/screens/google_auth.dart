import 'package:flutter/material.dart';

import '../services/firestore_manager.dart';
import '../services/login_google.dart';

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
            onPressed: () async {
              String? uid = await signInWithGoogle();
              if (uid != null) {
                bool isUserRegistered = await checkIfUserIsRegistered(uid);
                if (isUserRegistered) {
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                } else {
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/pre_register');
                  }
                }
              }else{
                //Navegar a screen de error
              }
            },
            child: const Text('Login with Google'),
          ),
        ],
      ),
    );
  }
}
