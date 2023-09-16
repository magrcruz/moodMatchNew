import 'package:flutter/material.dart';

class ChooseEmotion extends StatefulWidget {
  @override
  _ChooseEmotionState createState() => _ChooseEmotionState();
}

class _ChooseEmotionState extends State<ChooseEmotion> {
  String selectedEmotion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona Emoción'),
      ),
      body: ListView(
        children: emotions.map((emotion) {
          return ListTile(
            leading: Container(
              width: 48.0, // Ajusta el ancho del icono aquí
              child: Icon(emotionIcons[emotion]), // Icono correspondiente a la emoción
            ),
            title: Text(emotion),
            trailing: Radio<String>(
              value: emotion,
              groupValue: selectedEmotion,
              onChanged: (value) {
                setState(() {
                  selectedEmotion = value!;
                });
              },
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedEmotion.isNotEmpty) {
            // Aquí puedes realizar alguna acción con la emoción seleccionada.
            print('Emoción seleccionada: $selectedEmotion');
          } else {
            // Muestra un mensaje de error si no se selecciona ninguna emoción.
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Por favor, selecciona una emoción.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cerrar'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }

  final List<String> emotions = ['Feliz', 'Triste', 'Enojado', 'Asustado'];

  final Map<String, IconData> emotionIcons = {
    'Feliz': Icons.sentiment_very_satisfied,
    'Triste': Icons.sentiment_very_dissatisfied,
    'Enojado': Icons.mood_bad, // Usando Icons.mood_bad en lugar de sentiment_very_angry
    'Asustado': Icons.sentiment_dissatisfied,
  };

}
