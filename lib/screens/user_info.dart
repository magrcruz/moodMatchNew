import 'package:flutter/material.dart';

class UserInfo {
  final String name;
  final String nickname;
  final bool isPremium;
  final String profileImage;

  UserInfo({
    required this.name,
    required this.nickname,
    required this.isPremium,
    required this.profileImage,
  });
}

class UserProfileWidget extends StatelessWidget {
  final UserInfo userInfo;

  UserProfileWidget({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Establece el fondo en blanco
      padding: const EdgeInsets.all(20), // Añade un espaciado interior
      child: Column(
        children: [
          // Imagen de perfil del usuario
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),

          const SizedBox(height: 20), // Espaciado entre la imagen de perfil y el nombre/apodo

          // Nombre y apodo
          Text(
            userInfo.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none, // Elimina el subrayado
            ),
          ),
          Text(
            userInfo.nickname,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              decoration: TextDecoration.none, // Elimina el subrayado
            ),
          ),

          const SizedBox(height: 20), // Espaciado entre el nombre/apodo y el estado de la cuenta premium

          // Estado de la cuenta premium y botón correspondiente
          if (userInfo.isPremium)
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 32,
                ),
                SizedBox(width: 10),
                Text(
                  "Cuenta Premium",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amber,
                    decoration: TextDecoration.none, // Elimina el subrayado
                  ),
                ),
              ],
            )
          else
            ElevatedButton(
              onPressed: () {
                // Implementa aquí la lógica para obtener una cuenta premium
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
              child: const Text(
                "Obtener Premium",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none, // Elimina el subrayado
                ),
              ),
            ),
        ],
      ),
    );
  }
}
