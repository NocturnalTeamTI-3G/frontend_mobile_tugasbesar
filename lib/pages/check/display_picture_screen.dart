import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:frontend_mobile_tugasbesar/utils/color.dart';
import 'package:lottie/lottie.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    // Delay for 1 second before setting loading to false
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: Lottie.asset('assets/lottie/camera.json', width: 300),
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(
                          math.pi), // Membalikkan pratinjau kamera depan
                      child: Image.file(
                        File(widget.imagePath),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 64),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 37,
                                width: 37,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColors.mainColor,
                                  size: 24,
                                ),
                              ),
                            ),
                            const Text(
                              'Check your result',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 37,
                                width: 37,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.question_mark,
                                  color: AppColors.mainColor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
