import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../Services/firestore_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkUserSession();
    });
  }

  void checkUserSession() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await fetchAndSetUserData(user.uid);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/google_auth');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Bloquea la acción de retroceso
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFBF2828),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset('assets/animations/splash.json'),
              SvgPicture.asset(
                'assets/images/logo_2.svg',
                width: 220,
                height: 220,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
