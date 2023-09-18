import 'package:flutter/material.dart';
import 'package:mood_match/screens/index.dart';
import 'package:mood_match/screens/choose_emotion.dart';
import 'package:mood_match/screens/recommendation_results.dart';
import 'package:mood_match/screens/choose_content.dart';
import 'package:mood_match/screens/genre_preferences.dart';
import 'package:mood_match/screens/show_info.dart';
import 'package:mood_match/screens/signup.dart';
import 'package:mood_match/screens/user_info.dart';
import 'package:mood_match/screens/login.dart';
import 'package:mood_match/screens/home.dart'; // Asegúrate de importar la clase HomeScreen
import 'package:mood_match/models/user_profile.dart';

UserInfo dummyUser = UserInfo(
      name: "John Doe",
      nickname: "johndoe123",
      isPremium: true, // Cambia a false si el usuario no es premium
      profileImage:
          "https://example.com/profile-image.jpg", // URL de la imagen de perfil
    );

final Map<String, WidgetBuilder> routes = {
  '/': (context) => HomeScreen(), // Ruta de inicio
  '/home': (context) => HomeScreen(), // Ruta de inicio
  '/index': (context) => Index(),
  '/choose_emotion': (context) => ChooseEmotion(),
  '/recommendation_results': (context) => RecommendationResults(),
  '/choose_content': (context) => ChooseContent(),
  '/genre_preferences': (context) => GenrePreferences(),
  '/show_info': (context) => ShowInfo(),
  '/user_info': (context) => UserProfileWidget(userInfo: dummyUser),
  '/login':(context) => LoginPage(),
  '/signup':(context) => SignUp()
};
