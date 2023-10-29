import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:mood_match/Services/API.dart'; // Reemplaza esto con el nombre de tu servicio de API
import 'package:mood_match/controllers/genresClassification.dart';
import 'package:mood_match/models/contentDetails.dart';

import 'package:mood_match/Models/SearchResult.dart'; 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mood_match/models/MovieSerie.dart';

/*
Modificacion para que trabaje de forma
Coleccion -> documento -> campo (coleccion) -> documento -> campos
Historial -> uid -> RecomendacionesPasadas -> datenow -> left, array de recomendaciones
*/

final FirebaseAuth _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;
String? userUid = user?.uid;

String defaultimg = "https://firebasestorage.googleapis.com/v0/b/moodmatch-57ae2.appspot.com/o/defaultImages%2FdefaultMovie.png?alt=media&token=09516e2f-7862-4ade-a9f8-3c7339d56f49&_gl=1*487rno*_ga*NTI4NDgxMjk2LjE2OTU1MDI3MjU.*_ga_CW55HF8NVT*MTY5ODAzMzc4NS4xOS4xLjE2OTgwMzQxNzQuMzQuMC4w";
String defaultimgSong = "https://firebasestorage.googleapis.com/v0/b/moodmatch-57ae2.appspot.com/o/defaultImages%2FdefaultMovie.png?alt=media&token=09516e2f-7862-4ade-a9f8-3c7339d56f49&_gl=1*487rno*_ga*NTI4NDgxMjk2LjE2OTU1MDI3MjU.*_ga_CW55HF8NVT*MTY5ODAzMzc4NS4xOS4xLjE2OTgwMzQxNzQuMzQuMC4w";

Map<String, String> label_meaning = {
    'LABEL_0': 'sadness',
    'LABEL_1': 'joy',
    'LABEL_2': 'love',
    'LABEL_3': 'anger',
    'LABEL_4': 'fear',
    'LABEL_5': 'surprise',
};

//Con APIService
/*
Future<ContentDetails> extractContentDetailsFromMovie(num movieId) async {
  // Obtiene los detalles de la película.
  final apiService = APIService();
  final MovieDetail movieDetail = await apiService.getMovieDetail(movieId.toString());
  List<String> platforms = ["Netflix"];

  // Extrae los detalles del contenido.
  final ContentDetails contentDetails = ContentDetails(
    genre: movieDetail.genres?.map((v) => v.name).join(', ') ?? '',
    synopsisOrArtist: movieDetail.overview,
    platforms: platforms,//movieDetail.platforms,
    imageUrl: 'https://image.tmdb.org/t/p/w500' + (movieDetail.backdropPath ?? ''));
  return contentDetails;
}
*/

//From here
/*
Modificacion para que trabaje de forma
Coleccion -> documento -> campo (coleccion) -> documento -> campos
Historial -> uid -> RecomendacionesPasadas -> datenow -> utilizadas
                                                      -> recomendaciones(array)
*/
num maxRecomendaciones = 5;
Future<void> incrementarRecomendacionesHoy() async {
  final firestore = FirebaseFirestore.instance;
  final userDoc = firestore.collection('Historial').doc(userUid);

  // Obtener la fecha de hoy en formato YYYY-MM-DD
  DateTime now = DateTime.now();
  String formattedDate = "${now.year}-${now.month}-${now.day}";

  final recomendacionesPasadasDoc = userDoc.collection('RecomendacionesPasadas').doc(formattedDate);

  // Verificar si el documento de la fecha actual existe
  final docSnapshot = await recomendacionesPasadasDoc.get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data() as Map<String, dynamic>;
    final utilizadas = data['utilizadas'] ?? 0;
    
    await recomendacionesPasadasDoc.set(
      {'utilizadas': utilizadas + 1 },
      SetOptions(merge: true),
    );
  } else {
    // El documento no existe, créalo con el campo 'utilizadas' y un valor predeterminado 
    await recomendacionesPasadasDoc.set({'utilizadas': maxRecomendaciones-1});
  }
}

Future<bool> quedanRecomendaciones(num maxRecomendaciones) async {
  final firestore = FirebaseFirestore.instance;
  final userDoc = firestore.collection('Historial').doc(userUid);

  // Obtener la fecha de hoy en formato YYYY-MM-DD
  DateTime now = DateTime.now();
  String formattedDate = "${now.year}-${now.month}-${now.day}";

  // Obtener el documento correspondiente a la fecha de hoy
  final docSnapshot = await userDoc.collection('RecomendacionesPasadas').doc(formattedDate).get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data() as Map<String, dynamic>;
    final recomendacionesutilizadas = data['utilizadas'] ?? 0;

    // Verificar si no es mayor que la variable
    return recomendacionesutilizadas<maxRecomendaciones;
  }
  return true; // Devolver true si el documento no existe
}

/**
    
*/


Future<List<MovieSerie>> getRandomMoviesSeries(String type, String emotion) async {
  final firestore = FirebaseFirestore.instance;

  if (await quedanRecomendaciones(maxRecomendaciones)) {
      // El número de recomendaciones es aceptable, haz algo aquí
      incrementarRecomendacionesHoy();
      print("Número de recomendaciones aceptable");
  } else {
    // El número de recomendaciones excede el límite, sal del bucle o la función
    print("Número de recomendaciones excede el límite");
    return []; // Esto es válido solo dentro de un bucle
  }

  Map<String, String> typeMap = {
    'music': 'songs',
    'movie': 'Movies',
    'tv': 'Series',
  };
  type = typeMap[type]!;

  if(type == "songs"){
      Map<String, num> numEmocion = {
        'joy' : 1,
        'sadness' : 2,
        'fear' : 3,
        'angry' : 4,
      };
      Map<num, String> emocionNum = {
        1: 'joy' ,
        2:'sadness' ,
        3: 'fear' ,
        4: 'angry' ,
      };
      num? emotionNumber = numEmocion[emotion];

      final querySnapshot = await firestore
        .collection(type)
        .where('emotion', isEqualTo: emotionNumber)
        .get();

      final documents = querySnapshot.docs;
      if (documents.isEmpty) {
        print("No hay suficientes datos que cumplan con los criterios.");
        return [];
        //Aqui colocar que ponga de todos los generos
      }

      final random = Random();
      final selectedDocuments = <DocumentSnapshot>[];

      while (selectedDocuments.length < 5) {
        final randomIndex = random.nextInt(documents.length);
        final randomDocument = documents[randomIndex];

        if (!selectedDocuments.contains(randomDocument)) {
          selectedDocuments.add(randomDocument);
        }
      }
      List<MovieSerie> data = selectedDocuments.map((doc) {
        //final Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        MovieSerie aux = MovieSerie.songfromFirestore(doc);
        return aux;
      }).toList();
      
      print(data);
      return data; 
    }


  // Realiza una consulta a la colección "movies_series" en Firestore
  final querySnapshot = await firestore
      .collection(type)
      .where('emocion', isEqualTo: emotion)
      .where('inPeru', isEqualTo: "True") 
      .get();


  final documents = querySnapshot.docs;

  if (documents.isEmpty) {
    throw Exception("No hay suficientes datos que cumplan con los criterios.");
    //Aqui colocar que ponga de todos los generos
  }

  // Add here recommendations

  final random = Random();
  final selectedDocuments = <DocumentSnapshot>[];

  if(documents.length<5){
    for (int i = 0; i < documents.length; i++) {
      selectedDocuments.add(documents[i]);
    }
  }
  else{
    while (selectedDocuments.length < 5) {
    final randomIndex = random.nextInt(documents.length);
    final randomDocument = documents[randomIndex];

    if (!selectedDocuments.contains(randomDocument)) {
      selectedDocuments.add(randomDocument);
    }
  }
  }
  List<MovieSerie> data = selectedDocuments.map((doc) {
    //final Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
    MovieSerie aux = MovieSerie.fromFirestore(doc);
    return aux;
  }).toList();

  return data;
}


//Para guardar los generos

void updateGenresInFirebase(List<String> selectedGenresMovies, String campo) async {
  final firestore = FirebaseFirestore.instance;
  final userDocument = firestore.collection('preferences').doc(userUid);

  // Consulta la base de datos para obtener los datos existentes del usuario
  final userSnapshot = await userDocument.get();
  if (userSnapshot.exists) {
    // Convierte los géneros en una lista de enteros utilizando los datos de género proporcionados
    List selectedGenreIds = selectedGenresMovies.map((genre) {
      // Busca el género por su nombre y obtén el ID
      final genreData = genres.firstWhere((genreData) => genreData["name"] == genre, orElse: () => null);
      return genreData != null ? genreData["id"] : null;
    }).where((id) => id != null).toList();

    // Actualiza el campo "generos" en Firestore
    await userDocument.update({
      "movies-genres": selectedGenreIds,
    });
  }
}

void updateSongsInFirebase(List<String> selectedSongs) async {
  final firestore = FirebaseFirestore.instance;
  final userDocument = firestore.collection('preferences').doc(userUid);

  // Consulta la base de datos para obtener los datos existentes del usuario
  final userSnapshot = await userDocument.get();
  if (userSnapshot.exists) {
    // Convierte las canciones en una lista de números utilizando el mapeo inverso
    List<int?> selectedSongNumbers = selectedSongs
        .map((song) => invertedGenreMusicMap[song])
        .where((number) => number != null)
        .toList();

    // Actualiza el campo "canciones" en Firestore
    await userDocument.update({
      "song-genres": selectedSongNumbers,
    });
  }
}

Future<void> agregarRecomendacion(String tconst, String name) async {
  final historialRef = FirebaseFirestore.instance.collection('Historial');
  final uidRef = historialRef.doc(userUid);

  // Obtén la fecha y hora actual
  final now = DateTime.now();
  String formattedDate = "${now.year}-${now.month}-${now.day}";


  // Crea un objeto con los datos de la recomendación
  final recomendacion = {
    'tconst': tconst,
    'name': name,
    'hora': now,
  };

  try {
    // Agrega el objeto a la colección "recomendaciones"
    await uidRef.collection('RecomendacionesPasadas').doc(formattedDate).update({
      'recomendaciones': FieldValue.arrayUnion([recomendacion]),
    });
    print('Recomendación agregada correctamente');
  } catch (error) {
    print('Error al agregar la recomendación: $error');
  }
}

Future<dynamic> obtenerUltimaRecomendacion() async {
  final historialRef = FirebaseFirestore.instance.collection('Historial');
  final uidRef = historialRef.doc(userUid);

  final now = DateTime.now();
  String formattedDate = "${now.year}-${now.month}-${now.day}";

  try {
    final docSnapshot = await uidRef.collection('RecomendacionesPasadas').doc(formattedDate).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      final recomendaciones = data?['recomendaciones'];

      if (recomendaciones is List && recomendaciones.isNotEmpty) {
        // Supongamos que cada mapa en la lista contiene una clave "tconst" y una clave "name"
        final ultimoElemento = recomendaciones.last;
        if (ultimoElemento is Map<String, dynamic>) {
          final tconst = ultimoElemento['tconst'];
          final name = ultimoElemento['name'];

          if (tconst != null && name != null) {
            return name;
          }
        }
      }
    }
  } catch (error) {
    print('Error al obtener el último elemento: $error');
  }

  return "Nada por hoy";
}

Future<num> obtenerNumeroRecomendacionesRestantes() async {
  final firestore = FirebaseFirestore.instance;
  final userDoc = firestore.collection('Historial').doc(userUid);

  // Obtener la fecha de hoy en formato YYYY-MM-DD
  DateTime now = DateTime.now();
  String formattedDate = "${now.year}-${now.month}-${now.day}";

  // Obtener el documento correspondiente a la fecha de hoy
  final docSnapshot = await userDoc.collection('RecomendacionesPasadas').doc(formattedDate).get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data() as Map<String, dynamic>;
    final recomendacionesutilizadas = data['utilizadas'] ?? 0;

    // Verificar si no es mayor que la variable
    return maxRecomendaciones - recomendacionesutilizadas;
  }
  return maxRecomendaciones; // Devolver true si el documento no existe
}

Stream<String> obtenerUltimaRecomendacionStream() {
  // Crea un controlador de flujo (StreamController) para emitir valores
  final StreamController<String> controller = StreamController<String>();

  // Llama a obtenerUltimaRecomendacion() para obtener la recomendación
  obtenerUltimaRecomendacion().then((recomendacion) {
    // Emite la recomendación al stream
    controller.add(recomendacion);
  }).catchError((error) {
    // Maneja errores y emite un valor vacío o un mensaje de error
    controller.addError(error.toString());
  });

  // Devuelve el stream
  return controller.stream;
}




/*
Future<List<SearchResult>> getRecommended(
    String type, String emotion) async {//Actualizar a lista d strings
  const double threshold = 0.8;
  try {
    final apiService = APIService(); // Reemplaza YourAPIService con tu clase de servicio de API
    //final genres = "16%2C35"; // Reemplaza esto con los géneros que deseas buscar
    //String genres = getGenreIdsAsString(emotion);
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
*/

/*Future<ContentDetails> extractContentDetailsFromMovie(num movieId) async {
  // Obtiene los detalles de la película.
  final apiService = APIService();
  final MovieDetail movieDetail = await apiService.getMovieDetail(movieId.toString());
  List<String> platforms = ["Netflix"];

  // Extrae los detalles del contenido.
  final ContentDetails contentDetails = ContentDetails(
    genre: movieDetail.genres?.map((v) => v.name).join(', ') ?? '',
    synopsisOrArtist: movieDetail.overview,
    platforms: platforms,//movieDetail.platforms,
    imageUrl: 'https://image.tmdb.org/t/p/w500' + (movieDetail.backdropPath ?? ''));
  return contentDetails;
}*/

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
//Ultima recomendacion
/*
Future<void> guardarUltimaRecomendacion(String? ultimaRecomendacion) async {
  try {
    // Acceder a la instancia de Firestore
    final firestore = FirebaseFirestore.instance;

    // Referencia al documento del usuario en la colección nPreferences
    final docReference = firestore.collection('Historial').doc(userUid);

    // Actualizar el campo ultimaRecomendacion con el nuevo valor
    await docReference.update({'ultimaRecomendacion': ultimaRecomendacion});

    print('Última recomendación guardada con éxito.');
  } catch (error) {
    print('Error al guardar la última recomendación: $error');
  }
}

Future<String> obtenerUltimaRecomendacion() async {
  try {
    // Acceder a la instancia de Firestore
    final firestore = FirebaseFirestore.instance;

    // Obtener la referencia al documento del usuario en la colección nPreferences
    final docReference = firestore.collection('nPreferences').doc(userUid);

    // Obtener el documento y extraer el valor del campo ultimaRecomendacion
    final docSnapshot = await docReference.get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      final ultimaRecomendacion = data['ultimaRecomendacion'] as String;

      return ultimaRecomendacion;
    } else {
      // El documento no existe o no tiene el campo ultimaRecomendacion
      return '';
    }
  } catch (error) {
    print('Error al obtener la última recomendación: $error');
    return '';
  }
}
*/
