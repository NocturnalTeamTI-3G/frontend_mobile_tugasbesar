import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/login/intro_page.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: AnimatedSplashScreen(
        splash: Stack(
          children: [
            Center(
              child: LottieBuilder.asset('assets/lottie/camera.json', width: 400),
              // child: Text('SkinAssist', style: TextStyle(fontSize: 24, color: AppColors.white, fontWeight: FontWeight.w700),),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Skin Assist App',
                        style: TextStyle(fontSize: 20, color: AppColors.mainColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        nextScreen: const IntroPage(),
        splashIconSize: 1000,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
