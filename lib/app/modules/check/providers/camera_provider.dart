import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/history/history_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/check/services/camera_services.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

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
    final selectedCamera = cameras.length > 1 ? cameras[1] : cameras[0];

    try {
      _cameraController = CameraController(
        selectedCamera,
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
        final imageFile = File(image.path);

        // Decode gambar menggunakan pustaka `image`
        final originalImage = img.decodeImage(await imageFile.readAsBytes());

        // Balik gambar secara horizontal
        final fixedImage = img.flipHorizontal(originalImage!);

        // Simpan hasil gambar yang sudah diperbaiki
        final fixedImageFile = File(image.path)
          ..writeAsBytesSync(img.encodeJpg(fixedImage));

        late HistoryModel history;

        final response = await _cameraServices.ScanDisease(fixedImageFile.path);

        if (response.statusCode == 200) {
          final data = response.data['data'];
          history = HistoryModel.fromJson(data);
        }

        Get.toNamed(AppRouters.cameraResult, arguments: history);
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
