class ContentDetails {
  final String genre;
  final String? synopsisOrArtist;
  final List<String> platforms;
  final String imageUrl;

  ContentDetails({
    required this.genre,
    this.synopsisOrArtist,
    required this.platforms,
    required this.imageUrl,
  });
}