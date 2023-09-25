import 'package:flutter/material.dart';
import 'package:mood_match/controllers/recommendations.dart';
import 'package:mood_match/models/SearchResult.dart';
class RecommendationResults extends StatefulWidget {
  final String? type;
  final String? selectedEmotion;

  RecommendationResults({
    this.type,
    this.selectedEmotion,
  });

  @override
  _RecommendationResultsState createState() => _RecommendationResultsState();
}

class _RecommendationResultsState extends State<RecommendationResults> {
  List<SearchResult>? _recommendations; // Cambio el tipo a List<SearchResult>

  @override
  void initState() {
    super.initState();
    _loadRecommendations(); // Llama a una función para cargar las recomendaciones
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
      // Manejar errores aquí
    }
  }

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
            if (_recommendations == null)
              CircularProgressIndicator() // Muestra un indicador de carga
            else if (_recommendations!.isEmpty)
              Text('No se encontraron resultados.') // Manejar el caso sin resultados
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _recommendations!.length,
                  itemBuilder: (context, index) {
                    final SearchResult result = _recommendations![index];
                    // Aquí puedes personalizar cómo se muestra cada SearchResult
                    return ListTile(
                      title: Text(result.originalTitle?? 'Título no disponible'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
