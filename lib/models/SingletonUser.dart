class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  UserSingleton._internal();

  String username = "";
  String profileImageUrl = "";
  bool isPremium = false;
  List<bool> _songGenres = List.generate(42, (index) => false);

  void setSongGenres(List<bool> genres) {
    if (genres.length == _songGenres.length) {
      _songGenres = List.from(genres);
    }
  }
}
