import 'package:flutter/material.dart';

class Working extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Working Screen - Espacio de Pruebas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '¡Bienvenido a la pantalla de pruebas!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar funcionalidades de prueba
                // Puedes usar esta pantalla para experimentar con diferentes widgets y características de Flutter.
              },
              child: Text('Ejecutar Prueba'),
            ),
          ],
        ),
      ),
    );
  }
}
