import 'package:cloud_firestore/cloud_firestore.dart';
String defaultimg = "https://firebasestorage.googleapis.com/v0/b/moodmatch-57ae2.appspot.com/o/defaultImages%2FdefaultMovie.png?alt=media&token=09516e2f-7862-4ade-a9f8-3c7339d56f49&_gl=1*487rno*_ga*NTI4NDgxMjk2LjE2OTU1MDI3MjU.*_ga_CW55HF8NVT*MTY5ODAzMzc4NS4xOS4xLjE2OTgwMzQxNzQuMzQuMC4w";
String defaultimgSong = "https://firebasestorage.googleapis.com/v0/b/moodmatch-57ae2.appspot.com/o/defaultImages%2FdefaultMovie.png?alt=media&token=09516e2f-7862-4ade-a9f8-3c7339d56f49&_gl=1*487rno*_ga*NTI4NDgxMjk2LjE2OTU1MDI3MjU.*_ga_CW55HF8NVT*MTY5ODAzMzc4NS4xOS4xLjE2OTgwMzQxNzQuMzQuMC4w";


String _mapEmotion(int emotionValue) {
  switch (emotionValue) {
    case 1:
      return "anger";
    case 2:
      return "happiness";
    case 3:
      return "surprise";
    default:
      return "unknown"; // Valor predeterminado en caso de que el número de emoción sea desconocido
  }
}

class MovieSerie {
  String tconst;
  String sinopsis;
  String emocion;
  List<int> genres;
  String primaryTitle;
  String titleType;
  List<String> plataformas;
  String imageUrl;
  

  MovieSerie({
    required this.tconst,
    required this.sinopsis,
    required this.emocion,
    required this.genres,
    required this.primaryTitle,
    required this.titleType,
    required this.plataformas,
    required this.imageUrl,
  });

  String get plataformasComoCadena => listToString(plataformas);
  String listToString(List<String> lista) {
  if (lista == null || lista.isEmpty) {
      return '';
    }
    return lista.join(', ');
  }

  factory MovieSerie.fromJson(Map<String, dynamic> json) {
    // Extrae y convierte los datos del JSON a las propiedades de la clase
    return MovieSerie(
      tconst: json['tconst'] ?? '',
      sinopsis: json['Sinopsis'] ?? '',
      emocion: json['emocion'] ?? '',
      genres: (json['genres'] as List<dynamic>).map((e) => e as int).toList(),
      primaryTitle: json['primaryTitle'] ?? '',
      titleType: json['titleType'] ?? '',
      plataformas: json['plataformas'] != null
        ? (json['plataformas'] as List<dynamic>).map((e) => e.toString()).toList()
        : [],
      imageUrl: json['imageUrl']
    );
  }

  factory MovieSerie.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    List<String> plataformas = [];

    if (data['plataformas'] is Map<String, dynamic> && data['plataformas'].isNotEmpty) {
      plataformas = data['plataformas'].values.whereType<String>().toList();
    }

    String urlsita = data['imagen'];
    if(urlsita == "https://image.tmdb.org/t/p/w500None") urlsita = defaultimg;

    return MovieSerie(
      tconst: document.id,
      sinopsis: data['Sinopsis'] ?? '',
      emocion: data['emocion'] ?? '',
      genres: (data['genres'] as List<dynamic>)?.map<int>((item) => item as int)?.toList() ?? [],
      primaryTitle: data['primaryTitle'] ?? '',
      titleType: data['titleType'] ?? '',
      plataformas: plataformas,
      imageUrl: urlsita,
    );
  }

  // Función para mapear valores numéricos de emoción a cadenas


  factory MovieSerie.songfromFirestore(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  return MovieSerie(
    tconst: document.id,
    sinopsis: data['author'] ?? '', // Usando 'sinopsis' en lugar de 'Sinopsis'
    emocion: data['emotion'] != null ? _mapEmotion(data['emotion']) : '', // Convertir emoción numérica a cadena
    genres: data['genre'] != null ? [data['genre']] : [], // Convertir género numérico a lista de enteros
    primaryTitle: data['title'] ?? '',
    titleType: data['type'] ?? '', // Usando 'type' en lugar de 'titleType'
    plataformas: ['Spotify'], // Puedes establecer esto en una lista vacía, ya que no se proporciona en los datos
    imageUrl: defaultimgSong, // Puedes establecer esto en una cadena vacía, ya que no se proporciona en los datos
  );
}


}

MovieSerie getDummyMovieSerie(){
    return MovieSerie(
      tconst : 'tconst',
      sinopsis: 'Sinopsis',
      emocion: 'emocion',
      genres: [1,2,3],
      primaryTitle: 'primaryTitle',
      titleType: 'titleType',
      plataformas:["plat1"],
      imageUrl: ""
    );
  }