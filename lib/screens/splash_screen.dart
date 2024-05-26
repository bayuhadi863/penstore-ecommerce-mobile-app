import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penstore/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:penstore/screens/bottom_navigation.dart';
import 'package:penstore/screens/auth/login_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<Widget> determineNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasSeenOnboarding = prefs.getBool('hasSeenOnboarding');

    if (hasSeenOnboarding == null || !hasSeenOnboarding) {
      return const OnboardingScreen();
    } else {
      return FirebaseAuth.instance.currentUser != null
          ? const MyBottomNavBar()
          : const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: const IconSplash(),
      nextScreen: FutureBuilder<Widget>(
        future: determineNextScreen(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading app"));
          } else {
            return snapshot.data!;
          }
        },
      ),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: const Color(0xFFFAFAFA),
      splashIconSize: double.infinity,
    );
  }
}

class IconSplash extends StatelessWidget {
  const IconSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/Logo_Splash.png",
            width: 103.67,
            height: 105,
          ),
          const SizedBox(height: 20),
          GradientText(
            "Penstore",
            colors: [const Color(0xFF424242), const Color(0xFF024358)],
            gradientDirection: GradientDirection.ltr,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          )
        ],
      ),
    );
  }
}
