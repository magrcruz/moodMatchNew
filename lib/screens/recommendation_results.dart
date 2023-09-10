import 'package:flutter/material.dart';

class RecommendationResults extends StatelessWidget {
  final String type;
  final String emotion;

  RecommendationResults({required this.type, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados de la Recomendación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tipo seleccionado: $type',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Emoción seleccionada: $emotion',
              style: TextStyle(fontSize: 20),
            ),
            // Aquí puedes agregar más widgets y lógica para la pantalla de resultados de recomendación
          ],
        ),
      ),
    );
  }
}
