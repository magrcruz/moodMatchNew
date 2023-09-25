import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SplashScreen2 extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen2> {
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
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/google_auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Bloquea la acción de retroceso
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFF1B1B1B),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(
                'assets/animations/splash2.json',
                frameRate: FrameRate(60),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                repeat: false,
              ),
              SvgPicture.asset(
                'assets/images/logo_2.svg',
                width: 250,
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
