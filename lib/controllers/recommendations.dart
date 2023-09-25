import 'dart:convert';

import 'package:mood_match/Services/API.dart'; // Reemplaza esto con el nombre de tu servicio de API
import 'package:mood_match/models/SearchResult.dart'; // Asegúrate de importar tus modelos correctamente
import 'package:mood_match/controllers/genresClassification.dart';

Map<String, String> label_meaning = {
    'LABEL_0': 'sadness',
    'LABEL_1': 'joy',
    'LABEL_2': 'love',
    'LABEL_3': 'anger',
    'LABEL_4': 'fear',
    'LABEL_5': 'surprise',
};

Future<List<SearchResult>> getRecommended(
    String type, String emotion) async {//Actualizar a lista d strings
  const double threshold = 0.8;
  try {
    final apiService = APIService(); // Reemplaza YourAPIService con tu clase de servicio de API
    //final genres = "16%2C35"; // Reemplaza esto con los géneros que deseas buscar
    String genres = getGenreIdsAsString(emotion);
    final results = await apiService.getMoviesEpisodes(type, genres);

    final List<SearchResult> recommendedMovies = [];

    //Filtrado
    for (final result in results) {
      final sentiment = emotion;//await check_sentiment(result); // Reemplaza esto con tu lógica para calcular el sentimiento
      if (sentiment == emotion) {
        recommendedMovies.add(result);
      }

      if (recommendedMovies.length >= 5) {
        break; // Límite de resultados recomendados alcanzado
      }
      //print(result);
    }

    // Paso 6: Retornar la lista de películas recomendadas
    return recommendedMovies;
  } catch (error) {
    // Manejar errores aquí
    print("Error: $error");
    return [];
  }
}

Future<double> calculateSentiment(SearchResult result) async {
  // Implementa aquí tu lógica para calcular el sentimiento de un resultado dado
  // Debe devolver un valor numérico que represente el sentimiento
  // Puedes utilizar bibliotecas de procesamiento de lenguaje natural para esta tarea

  // Ejemplo asincrónico para simular un cálculo de sentimiento (reemplaza con tu lógica real)
  await Future.delayed(Duration(seconds: 1));
  return 0.7; // Valor de ejemplo, reemplázalo con la lógica real
}


/*
Future<String> check_sentiment(String? inputText) async {
  final headers = <String, String>{'Content-Type': 'application/json'};
  final apiURL = "https://api-inference.huggingface.co/models/TFMUNIR/distilbert-base-uncased-finetuned-emotion-movies-186k";
  final data = jsonEncode(<String, dynamic>{"inputs": inputText});

  final response = await http.post(Uri.parse(apiURL), headers: headers, body: data);

  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);
    if (responseData.isNotEmpty) {
      final List<dynamic> labelsData = responseData[0];
      if (labelsData.isNotEmpty) {
        // Encuentra el label con el puntaje más alto
        double maxScore = 0;
        String maxLabel = "";
        for (final labelData in labelsData) {
          final double score = labelData['score'];
          final String label = labelData['label'];
          if (score > maxScore) {
            maxScore = score;
            maxLabel = label;
          }
        }
        return maxLabel;
      }
    }
    throw Exception('No se encontraron labels en la respuesta.');
  } else if (response.statusCode == 429 && response.body.contains('estimated_time')) {
    final Map<String, dynamic> errorData = json.decode(response.body);
    final double estimatedTime = errorData['estimated_time'] ?? 0;
    // Espera el tiempo especificado antes de volver a intentar
    await Future.delayed(Duration(seconds: estimatedTime.toInt()));
    // Llama de nuevo a la función query
    return await check_sentiment(inputText);
  } else {
    throw Exception('Fallo al cargar los datos.');
  }
}*/
