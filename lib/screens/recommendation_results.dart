import 'package:flutter/material.dart';

class RecommendationResults extends StatefulWidget {
  final String? type;
  final String? selectedEmotion;

  RecommendationResults({
    this.type, // Proporciona un valor predeterminado
    this.selectedEmotion,
  });

  @override
  _RecommendationResultsState createState() => _RecommendationResultsState();
}


class _RecommendationResultsState extends State<RecommendationResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de la Recomendación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tipo seleccionado: ${widget.type}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Emoción seleccionada: ${widget.selectedEmotion}',
              style: const TextStyle(fontSize: 20),
            ),
            // Aquí puedes agregar más widgets y lógica para la pantalla de resultados de recomendación
          ],
        ),
      ),
    );
  }
}
