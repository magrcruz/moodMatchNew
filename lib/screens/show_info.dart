import 'package:flutter/material.dart';

class ShowInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial de la Aplicación'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '¡Bienvenido a nuestra aplicación!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'En esta aplicación, puedes explorar y descubrir música, películas y series de televisión.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Funciones Principales:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Buscar y descubrir contenido.'),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Guardar tus favoritos.'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Administrar tu perfil y preferencias.'),
            ),
            SizedBox(height: 16),
            Text(
              'Cómo Usar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. Utiliza la barra de búsqueda para encontrar música, películas y series.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '2. Guarda tus favoritos haciendo clic en el ícono de estrella.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '3. Personaliza tu perfil y preferencias en la sección de ajustes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '¡Disfruta de la aplicación y explora todo lo que tenemos para ofrecer!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
