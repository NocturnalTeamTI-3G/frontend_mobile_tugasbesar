import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/pages/check/display_picture_screen.dart';
import 'dart:math' as math;

import 'package:frontend_mobile_tugasbesar/utils/color.dart';

class CheckPage extends StatefulWidget {
  CheckPage({Key? key}) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Fungsi untuk inisialisasi kamera depan
  Future<void> _initializeCamera() async {
    late final List<CameraDescription> _cameras;
    try {
      _cameras = await availableCameras();

      _cameraController = CameraController(
        _cameras[1],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController?.initialize();

      // Zoom untuk pratinjau lebih dekat (opsional)
      // await _cameraController?.setZoomLevel(1.5);

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController != null && _isCameraInitialized) {
      try {
        final image = await _cameraController!.takePicture();
        // Navigate to the display screen with the captured image
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(imagePath: image.path),
          ),
        );
      } catch (e) {
        print('Error taking picture: $e');
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Stack(
              children: [
                Positioned.fill(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi)
                      ..scale(1.2), // Membalikkan pratinjau kamera depan
                    child: AspectRatio(
                      aspectRatio: 16 / 9, // Menetapkan rasio aspek 16:9
                      child: CameraPreview(_cameraController!),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/overlay.png',
                    height: MediaQuery.of(context).size.height * 0.48,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 64, bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              'Check your face',
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
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.mainColor,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  )),
                              child: Material(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: AppColors.thirdColor,
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    _takePicture();
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: AppColors.white,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Make sure there is nothing blocking your face',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ), // Menampilkan loading jika kamera belum siap
            ),
    );
  }
}
