import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/intro_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/pages/login_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/main_page.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  final bool isLoggedIn;
  final bool onBoardingComplete;
  const Splash({Key? key, required this.isLoggedIn, required this.onBoardingComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: AnimatedSplashScreen(
        splash: Stack(
          children: [
            // Lottie Animation
            Center(
              child:
                  LottieBuilder.asset('assets/lottie/camera.json', width: 400),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'SkinAssist App',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
        nextScreen: isLoggedIn ? const MainPage() : onBoardingComplete ? const LoginPage() : const IntroPage(),
        splashIconSize: 1000,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
