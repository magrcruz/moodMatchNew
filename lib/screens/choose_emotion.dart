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
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: emotions.length,
              itemBuilder: (context, index) {
                final emotion = emotions[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEmotion = emotion;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: selectedEmotion == emotion ? MyApp.customSwatch[900] : MyApp.customSwatch,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/${emotion.toLowerCase()}.png',
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: // :
            ElevatedButton(
              onPressed: () {
                if (selectedEmotion.isNotEmpty) {
                  // Aquí puedes realizar alguna acción con la emoción seleccionada y 'type'
                  print('Emoción seleccionada: $selectedEmotion');
                  if (type != null) {
                    print('Type: $type');
                  }

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
              },
              child: const Text('Enviar Emoción'),
            ),

          ),
        ],
      ),
    );
  }

  final List<String> emotions = ['Feliz', 'Triste', 'Enojado', 'Asustado'];
}
