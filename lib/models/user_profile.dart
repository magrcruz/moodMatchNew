class UserProfile {
  final String username;
  final String profileImageURL;
  final bool? isPremium;

  UserProfile({
    required this.username,
    required this.profileImageURL,
    this.isPremium,
  });
}
