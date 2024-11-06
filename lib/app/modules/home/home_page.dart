import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_mobile_tugasbesar/app/widgets/custom_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _mainHomePageState createState() => _mainHomePageState();
}

// ignore: camel_case_types
class _mainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppbar(
          title: 'Home',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.pink[100],
              ),
              child: Row(
                children: [
                  // animation of cute pictures
                  Container(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.deepPurple,
                    ),
                  ),
                  // how do you feel today?
                  Column(
                    children: [
                      Text(
                        "How do you feel?",
                      ),
                      Text(
                        "Fill out your medical card right now!",
                      ),
                      Container(
                        child: Center(
                          child: Text("Get started"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
