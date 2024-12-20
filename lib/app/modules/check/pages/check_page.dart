import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/check/providers/camera_provider.dart';
import 'dart:math' as math;

import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraProvider()..initializeCamera(),
      child: Consumer<CameraProvider>(
        builder: (context, cameraProvider, _) {
          final size = MediaQuery.of(context).size;

          if (!cameraProvider.isCameraInitialized ||
              cameraProvider.cameraController == null) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ),
            );
          }

          // Aspect ratio scaling
          var scale = size.aspectRatio *
              cameraProvider.cameraController!.value.aspectRatio;
          if (scale < 1) scale = 1 / scale;
          const double mirror = math.pi;

          return Scaffold(
            body: Stack(
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: cameraProvider
                              .cameraController!.description.lensDirection ==
                          CameraLensDirection.front
                      ? Matrix4.rotationY(mirror) // Mirror jika kamera depan
                      : Matrix4.identity(), // Tidak mirror jika kamera belakang
                  child: Transform.scale(
                    scale: scale,
                    child: Center(
                      child: CameraPreview(cameraProvider.cameraController!),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.black.withOpacity(0.5),
                          AppColors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/overlay.png',
                    height: MediaQuery.of(context).size.height * 0.48,
                    width: MediaQuery.of(context).size.width * 0.725,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
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
                            onTap: () async {
                              await cameraProvider.switchCamera();
                            },
                            child: Container(
                              height: 37,
                              width: 37,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.loop_rounded,
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
                              ),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: AppColors.thirdColor,
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  cameraProvider.takePicture(context);
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
                Consumer<CameraProvider>(
                    builder: (builder, cameraProvider, child) {
                  return cameraProvider.isLoading
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Center(
                            child: Lottie.asset('assets/lottie/camera.json',
                                width: 300),
                          ),
                        )
                      : const SizedBox();
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
