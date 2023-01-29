import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ium_project/controller/home_controller.dart';
import 'package:ium_project/main.dart';
import 'package:page_transition/page_transition.dart';
import 'home_page.dart';
import 'login_page.dart';

class Splash extends StatelessWidget {
  const Splash ({Key? key}) : super(key:key);


  @override
  Widget build (BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/writing2.png',
      nextScreen: token != '' && token != null ? HomePage() : const LoginPage(),
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xFF122b62),
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}