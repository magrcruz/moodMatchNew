class SongGenres {
  final int pk;
  final String name;
  final String image;

  SongGenres({required this.pk, required this.name, required this.image});

  factory SongGenres.fromMap(Map<String, dynamic> map) {
    return SongGenres(
      pk: map['pk'],
      name: map['name'],
      image: map['image'],
    );
  }
}
