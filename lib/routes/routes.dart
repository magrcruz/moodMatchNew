import 'package:flutter/material.dart';
import 'package:mood_match/screens/index.dart';
import 'package:mood_match/screens/choose_emotion.dart';
import 'package:mood_match/screens/recommendation_results.dart';
import 'package:mood_match/screens/choose_content.dart';
import 'package:mood_match/screens/song_genres_preferences.dart';
import 'package:mood_match/screens/genremoviesseries_preferences.dart';
import 'package:mood_match/screens/song_platforms_preferences.dart';
import 'package:mood_match/screens/show_info.dart';
import 'package:mood_match/screens/signup.dart';
import 'package:mood_match/screens/user_info.dart';
import 'package:mood_match/screens/google_auth.dart';
import 'package:mood_match/screens/details.dart';
import 'package:mood_match/screens/home.dart';
import '../screens/logout.dart';
import '../screens/pre_register.dart';
import '../screens/register.dart';
import '../screens/splash.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash':(context) => const SplashScreen(),
  '/login_google':(context) => const LoginGoogle(),
  '/pre_register':(context) => const PreRegisterScreen(),
  '/register':(context) => const RegisterScreen(),
  '/song_genres_preferences': (context) => const SongGenresPreferences(),
  '/song_platforms_preferences': (context) => const SongPlatformsPreferences(),

  '/movie_genres_preferences': (context) => GenremovieseriePreferences(),

  '/home': (context) => HomeScreen(),
  '/choose_content': (context) => const ChooseContent(),
  '/choose_emotion': (context) => ChooseEmotion(),
  '/index': (context) => Index(),

  '/recommendation_results': (context) => SongRecommendationResults(),

  '/show_info': (context) => ShowInfo(),
  '/user_info': (context) => UserInfoScreen(),
  // '/login':(context) => LoginPage(),
  '/signup':(context) => SignUp(),
  '/signout':(context) => signOutPage(),
  '/details':(context) => Details(id: 0000)

};
