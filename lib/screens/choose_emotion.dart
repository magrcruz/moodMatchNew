import 'package:flutter/material.dart';
import 'package:mood_match/main.dart';
import 'recommendation_results.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';

class ChooseEmotion extends StatefulWidget {
  const ChooseEmotion({super.key});

  @override
  State<ChooseEmotion> createState() => _ChooseEmotionState();
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
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Verificar si 'type' existe en los argumentos
    if (args != null && args.containsKey('type')) {
      type = args['type'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 120),
          // Espacio encima de la cuadrícula de botones
          const Text(
            '¿Cómo te sientes hoy?',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 30),
          // Espacio encima de la cuadrícula de botones
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: emotionsMap.length,
              itemBuilder: (context, index) {
                final emotion = emotionsMap.keys.elementAt(index);
                final spanishEmotion = emotionsMap[emotion]!;
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      selectedEmotion = emotion;
                    });

                    // Navegar a la pantalla de recomendaciones cuando se selecciona una emoción
                    navigateToRecommendationResults();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: selectedEmotion == emotion
                          ? MyApp.customSwatch[900]
                          : MyApp.customSwatch,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/${emotion.toLowerCase()}.png',
                          width: 100.0,
                          height: 100.0,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          spanishEmotion,
                          style: const TextStyle(
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
    // Crear una instancia de RecommendationResults y navegar a ella

    final recommendationResults = SongRecommendationResults(
      type: type,
      selectedEmotion: selectedEmotion,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => recommendationResults,
      ),
    );
  }
}
