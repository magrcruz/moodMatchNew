import 'package:flutter/material.dart';
import 'package:mood_match/main.dart';
import 'recommendation_results.dart';

class ChooseEmotion extends StatefulWidget {
  @override
  _ChooseEmotionState createState() => _ChooseEmotionState();
}

class _ChooseEmotionState extends State<ChooseEmotion> {
  String selectedEmotion = '';
  String? type; // Declarar type como una variable de instancia

  // Mapa que asocia emociones en inglés con su equivalente en español
  final Map<String, String> emotionsMap = {
    'joy': 'Feliz',
    'sadness': 'Triste',
    'anger': 'Enojado',
    'surprise': 'Asustado',
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Obtener los argumentos pasados desde la pantalla anterior
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Verificar si 'type' existe en los argumentos
    if (args != null && args.containsKey('type')) {
      type = args['type'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¿Cómo te sientes hoy?'),
      ),
      body: Column(
        children: [
          SizedBox(height: 100.0), // Espacio encima de la cuadrícula de botones
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: emotionsMap.length,
              itemBuilder: (context, index) {
                final emotion = emotionsMap.keys.elementAt(index);
                final spanishEmotion = emotionsMap[emotion]!;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEmotion = emotion;
                    });

                    // Navegar a la pantalla de recomendaciones cuando se selecciona una emoción
                    navigateToRecommendationResults();
                  },
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: selectedEmotion == emotion ? MyApp.customSwatch[900] : MyApp.customSwatch,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/${emotion.toLowerCase()}.png',
                          width: 100.0,
                          height: 100.0,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          spanishEmotion,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Función para navegar a la pantalla de recomendaciones
  void navigateToRecommendationResults() {
    if (selectedEmotion.isNotEmpty) {
      // Crear una instancia de RecommendationResults y navegar a ella
      final recommendationResults = RecommendationResults(
        type: type, // Reemplaza 'type' con el valor adecuado
        selectedEmotion: selectedEmotion, // Reemplaza 'selectedEmotion' con el valor adecuado
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => recommendationResults,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Por favor, selecciona una emoción.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }
}
