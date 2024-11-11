import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/check/services/camera_services.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool get isCameraInitialized => _isCameraInitialized;
  CameraController? get cameraController => _cameraController;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CameraServices _cameraServices = CameraServices();

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
        _isLoading = true;
        notifyListeners();

        final image = await _cameraController!.takePicture();

        final response = await _cameraServices.postImage(image.path);

        if (response.statusCode == 200) _isLoading = false;
        notifyListeners();
        Get.toNamed(AppRouters.cameraResult, arguments: image.path);

        _isLoading = false;
        notifyListeners();
      } catch (e) {
        print('Error taking picture: $e');
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
