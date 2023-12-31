import 'package:flutter/material.dart';
import 'package:mood_match/models/MovieSerie.dart';
//import 'package:mood_match/models/MovieSerie.dart';
import 'package:mood_match/screens/index.dart';
import 'package:mood_match/screens/choose_emotion.dart';
import 'package:mood_match/screens/recommendation_results.dart';
import 'package:mood_match/screens/choose_content.dart';
import 'package:mood_match/screens/genremusic_preferences.dart';
import 'package:mood_match/screens/genremoviesseries_preferences.dart';
import 'package:mood_match/screens/platforms_preferences.dart';
import 'package:mood_match/screens/show_info.dart';
import 'package:mood_match/screens/signup.dart';
import 'package:mood_match/screens/user_info.dart';
import 'package:mood_match/screens/login.dart';
import 'package:mood_match/screens/google_auth.dart';
import 'package:mood_match/screens/details.dart';
import 'package:mood_match/screens/home.dart'; // Asegúrate de importar la clase HomeScreen
import 'package:mood_match/models/user_profile.dart';
//import 'package:mood_match/Models/MovieSerie.dart';


import '../screens/logout.dart';
import '../screens/pre_register.dart';
import '../screens/register.dart';
import '../screens/splash.dart';
import '../screens/splash2.dart';



UserProfile dummyUser = UserProfile(
    username: 'Pantalon para tiendas',
    profileImageURL: 'https://images.milenio.com/PBYshjJo2dc007elHCdKpZdoqW8=/375x0/uploads/media/2023/08/31/pantalon-para-tiendas.jpeg',//Dejo de funcionar, se vencio el link
    isPremium: true,
    name: 'namesito'
);

final Map<String, WidgetBuilder> routes = {
  // '/': (context) => HomeScreen(), // Ruta de inicio
  '/home': (context) => HomeScreen(), // Ruta de inicio
  '/index': (context) => Index(),
  '/choose_emotion': (context) => ChooseEmotion(),
  '/recommendation_results': (context) => RecommendationResults(),
  '/choose_content': (context) => ChooseContent(),
  '/genremusic_preferences': (context) => GenremusicPreferences(),
  '/genremoviesseries_preferences': (context) => GenremovieseriePreferences(),
  '/platforms_preferences': (context) => PlatformsPreferences(),
  '/show_info': (context) => ShowInfo(),
  '/user_info': (context) => UserInfoScreen(),
  '/login':(context) => LoginPage(),
  '/signup':(context) => SignUp(),
  '/register':(context) => RegisterScreen(),
  '/pre_register':(context) => PreRegisterScreen(),
  '/splash':(context) => SplashScreen(),
  '/splash2':(context) => SplashScreen2(),
  '/google_auth':(context) => GoogleAuth(),
  '/signout':(context) => signOutPage(),
  '/details':(context) => Details(content: getDummyMovieSerie())

};
