import 'package:cloud_firestore/cloud_firestore.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  UserSingleton._internal();

  String username = "";
  String profileImageUrl = "";
  String email = "";
  String name = "";
  String lastName = "";
  Timestamp birthdate = Timestamp.now();
  bool premium = false;
  List<dynamic> songGenres = List.generate(42, (index) => false);
  List<dynamic> songServices = List.generate(3, (index) => false);

  void logOutUser() {
    username = "";
    profileImageUrl = "";
    email = "";
    name = "";
    lastName = "";
    birthdate = Timestamp.now();
    premium = false;
    songGenres = List.generate(42, (index) => false);
    songServices = List.generate(3, (index) => false);
  }

  void logInUser(Map<String, dynamic> data) {
    username = data['username'];
    profileImageUrl = data['profileImageUrl'];
    email = data["email"];
    name = data["name"];
    lastName = data["lastName"];
    birthdate = data["birthdate"];
    premium = data['premium'];
    songGenres = data['songGenres'];
    songServices = data['songServices'];
  }

  Map<String, Object> getUserData() {
    final userData = {
      'username': username,
      'profileImageUrl': profileImageUrl,
      'email': email,
      'name': name,
      'lastName': lastName,
      'birthdate': birthdate,
      'premium': premium,
      'songGenres': songGenres,
      'songServices': songServices
    };
    return userData;
  }
}
