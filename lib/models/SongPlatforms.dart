class SongPlatforms {
  final int pk;
  final String name;
  final String logo;

  SongPlatforms({required this.pk, required this.name, required this.logo});

  factory SongPlatforms.fromMap(Map<String, dynamic> map) {
    return SongPlatforms(
      pk: map['pk'],
      name: map['name'],
      logo: map['logo'],
    );
  }
}