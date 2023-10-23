class MovieSerie {
  String tconst;
  String sinopsis;
  String emocion;
  List<int> genres;
  String primaryTitle;
  String titleType;

  MovieSerie({
    required this.tconst,
    required this.sinopsis,
    required this.emocion,
    required this.genres,
    required this.primaryTitle,
    required this.titleType,
  });

  factory MovieSerie.fromJson(Map<String, dynamic> json) {
    // Extrae y convierte los datos del JSON a las propiedades de la clase
    return MovieSerie(
      tconst: json['tconst'] ?? '',
      sinopsis: json['Sinopsis'] ?? '',
      emocion: json['emocion'] ?? '',
      genres: (json['genres'] as List<dynamic>).map((e) => e as int).toList(),
      primaryTitle: json['primaryTitle'] ?? '',
      titleType: json['titleType'] ?? '',
    );
  }
}

