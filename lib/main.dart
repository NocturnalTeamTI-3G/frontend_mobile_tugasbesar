import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/pages/home/home_page.dart';
import 'package:frontend_mobile_tugasbesar/pages/login/intro_page.dart';
import 'package:frontend_mobile_tugasbesar/pages/template.dart';
import 'package:frontend_mobile_tugasbesar/splash.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Splash()
      home: IntroPage(),
      // home: MainHomePage(),
      // home: Template(),
    );
  }
}
