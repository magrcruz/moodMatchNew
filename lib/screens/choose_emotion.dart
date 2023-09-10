import 'package:flutter/material.dart';

class ChooseEmotion extends StatelessWidget {
  final String type;

  ChooseEmotion({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona una Emoción'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Seleccionaste la emoción: $type',
              style: TextStyle(fontSize: 20),
            ),
            // Aquí puedes agregar más widgets y lógica para la pantalla de selección de emoción
          ],
        ),
      ),
    );
  }
}
