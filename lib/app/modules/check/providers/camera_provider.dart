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

  Future<void> takePicture(BuildContext context) async {
    if (_cameraController != null && _isCameraInitialized) {
      try {
        _isLoading = true;
        notifyListeners();

        final image = await _cameraController!.takePicture();
        final imageFile = File(image.path);

        // flip image
        final originalImage = img.decodeImage(await imageFile.readAsBytes());
        final fixedImage = img.flipHorizontal(originalImage!);

        // crop image
        final screenHeight = MediaQuery.of(context).size.height;
        final targetHeight = (screenHeight * 0.7).toInt();

        final screenWidth = MediaQuery.of(context).size.width;
        final targetWidth = (screenWidth * 0.95).toInt();

        final cropX = (fixedImage.width - targetWidth) ~/ 2;
        final cropY = (fixedImage.height - targetHeight) ~/ 2;

        final croppedImage = img.copyCrop(fixedImage,
            x: cropX, y: cropY, width: targetWidth, height: targetHeight);

        final processedImageFile = File(imageFile.path)
          ..writeAsBytesSync(img.encodeJpg(croppedImage));

        late HistoryModel history;

        final response =
            await _cameraServices.scanDisease(processedImageFile.path);

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

  // Fungsi untuk mengganti kamera antara depan dan belakang
  Future<void> switchCamera() async {
    final cameras = await availableCameras();

    // Periksa apakah kamera saat ini adalah kamera depan
    if (_cameraController != null) {
      final currentLensDirection = _cameraController!.description.lensDirection;

      // Tentukan kamera berikutnya berdasarkan lens direction
      final CameraDescription? newCamera = cameras.firstWhere(
        (camera) =>
            camera.lensDirection != currentLensDirection, // Pilih yang berbeda
        orElse: () =>
            cameras.first, // Default kamera pertama jika tidak ditemukan
      );

      if (newCamera != null) {
        try {
          // Hentikan kamera saat ini
          await _cameraController?.dispose();

          // Inisialisasi kamera baru
          _cameraController = CameraController(
            newCamera,
            ResolutionPreset.high,
            enableAudio: false,
          );

          await _cameraController?.initialize();
          _isCameraInitialized = true;
          notifyListeners();
        } catch (e) {
          print('Error switching camera: $e');
        }
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
