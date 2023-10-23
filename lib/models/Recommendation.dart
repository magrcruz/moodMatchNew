class Recommendation {
  final String title;
  final String uid;

  Recommendation({
    required this.title,
    required this.uid,
  });

  factory Recommendation.fromMap(Map<String, dynamic> map, String documentId) {
    return Recommendation(
      title: map['title'] ?? '',
      uid: documentId,
    );
  }
}
