import 'package:flutter/material.dart';
import 'package:mood_match/main.dart';
import 'package:mood_match/controllers/recommendations.dart';
import 'package:mood_match/Models/SearchResult.dart';
import 'package:mood_match/widgets/Custom_Loader.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'details.dart';
class RecommendationResults extends StatefulWidget {
  final String? type;
  final String? selectedEmotion;

  RecommendationResults({
    this.type,
    this.selectedEmotion,
  });

  static const Map<String, String> typeMap = {
    'music': 'Música',
    'movie': 'Películas',
    'tv': 'Series',
  };

  static const Map<String, String> emotionMap = {
    'joy': 'Feliz',
    'sadness': 'Triste',
    'anger': 'Enojado',
    'surprise': 'Asustado',
  };

  @override
  _RecommendationResultsState createState() => _RecommendationResultsState();
}

class _RecommendationResultsState extends State<RecommendationResults> {
  List<SearchResult>? _recommendations;

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    try {
      final recommendations = await getRecommended(widget.type ?? '', widget.selectedEmotion ?? '');
      setState(() {
        _recommendations = recommendations as List<SearchResult>;
      });
    } catch (error) {
      print('Error loading recommendations: $error');
      _recommendations = [];
      // Handle errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    String typeText = RecommendationResults.typeMap[widget.type] ?? widget.type ?? 'Desconocido';
    String emotionText =
        RecommendationResults.emotionMap[widget.selectedEmotion] ?? widget.selectedEmotion ?? 'Desconocido';
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              'Recomendaciones para ti',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 5,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Contenido',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$typeText',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 5,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Emoción',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$emotionText',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_recommendations == null)
              CustomLoader()
            else if (_recommendations!.isEmpty)
              Text('No se encontraron resultados.')
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int index = 0; index < _recommendations!.length; index++)
                        ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: MyApp.customSwatch,
                            child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                          ),
                          title: Text(
                            _recommendations![index].originalTitle ?? 'Título no disponible',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              final contentSelected = Details(
                                id: _recommendations![index].id!,
                                type: widget.type, // Reemplaza 'type' con el valor adecuado
                                title: _recommendations![index].originalTitle, // Reemplaza 'selectedEmotion' con el valor adecuado
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => contentSelected,
                                ),
                              );
                            },
                            child: Text('Detalles', style: TextStyle(fontSize: 14)),
                            style: ElevatedButton.styleFrom(
                              primary: MyApp.customSwatch,
                              onPrimary: Colors.white,
                            ),
                          ),
                          onTap: () {

                          },
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

