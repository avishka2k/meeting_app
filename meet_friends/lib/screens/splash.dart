import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meet_friends/firebaseAuth/googleAuth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/logoIcon.png',
      nextScreen: GoogleAuth().handleAuthSate(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: HexColor('#323745'),
    );
  }
}
