class Song {
  final String author;
  final int emotion;
  final int genre;
  final String link;
  final String title;

  Song({
    required this.author,
    required this.emotion,
    required this.genre,
    required this.link,
    required this.title,
  });

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      author: map['author'] ?? '',
      emotion: map['emotion'] ?? 0,
      genre: map['genre'] ?? 0,
      link: map['link'] ?? '',
      title: map['title'] ?? '',
    );
  }
}
