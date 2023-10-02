import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/user_profile.dart';

class UserInfoScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String userImageURL = user?.photoURL ?? 'assets/images/logo.png'; // URL de imagen de usuario o imagen de respaldo
    String username = user?.displayName ?? "Usuario";
    String userEmail = user?.email ?? "correo@example.com";
    bool isPremium = true; // Puedes obtener esta información desde donde sea que determines si un usuario es premium o no

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                'Mi Perfil',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              CircleAvatar(
                backgroundImage: NetworkImage(userImageURL),
                radius: 50,
              ),
              SizedBox(height: 20),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.person, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'Nombre de usuario',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    username,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.email, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'Correo Electrónico',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    userEmail,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.star, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'Premium',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    isPremium ? 'Sí' : 'No',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
