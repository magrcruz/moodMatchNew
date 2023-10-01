import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/contentloader.json', // Reemplaza con la ubicación de tu archivo de animación Lottie
        width: 250, // Personaliza el ancho de la animación según tus necesidades
        height: 250, // Personaliza la altura de la animación según tus necesidades
        fit: BoxFit.contain, // Ajusta la animación dentro del espacio definido
        repeat: true, // Define si la animación debe repetirse
      ),
    );
  }
}