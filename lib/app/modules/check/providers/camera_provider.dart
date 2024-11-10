import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool get isCameraInitialized => _isCameraInitialized;
  CameraController? get cameraController => _cameraController;

  // Fungsi untuk inisialisasi kamera depan
  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    try {
      _cameraController = CameraController(
        cameras[1],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController?.initialize();
      _isCameraInitialized = true;
      notifyListeners();
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> takePicture() async {
    if (_cameraController != null && _isCameraInitialized) {
      try {
        final image = await _cameraController!.takePicture();
        Get.toNamed(AppRouters.cameraResult, arguments: image.path);
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
}
