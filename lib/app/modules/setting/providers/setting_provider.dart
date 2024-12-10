import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/faq/faq_model.dart';
import 'package:frontend_mobile_tugasbesar/app/models/user/user_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/services/auth_service.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/home/services/user_service.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/setting/services/setting_service.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  final SettingService _settingService = SettingService();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _selectedValue;
  UserModel? user;
  List<FaqModel>? faqs;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  File? get image => _image;
  String? get selectedValue => _selectedValue;

  SettingProvider() {
    getUser();
  }

  Future<void> logout() async {
    Get.dialog(
      AlertDialog(
        content: const Text('Apakah Anda yakin ingin keluar dari akun ini?',
            style: TextStyle(fontSize: 17)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Batal', style: TextStyle(fontSize: 17)),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final response = await _authService.logout();

                if (response.statusCode == 200) {
                  GoogleSignIn().signOut();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  await prefs.setBool('isLoggedIn', false);

                  Get.snackbar('Berhasil', 'Anda berhasil keluar dari akun',
                      backgroundColor: Colors.green, colorText: Colors.white);
                  Get.offAllNamed('/login');
                } else {
                  Get.snackbar(
                    'Terjadi Kesalahan',
                    'Silahkan coba lagi atau hubungi admin',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              } catch (e) {
                Get.snackbar(
                  'Terjadi Kesalahan',
                  'Tidak dapat melakukan logout. Silahkan coba lagi.',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
            ),
            child: const Text(
              'Ya',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return;
    }

    try {
      final response = await _userService.getUser();

      if (response.statusCode == 200) {
        final data = response.data['data'];
        user = UserModel.fromJson(data);
        _selectedValue = user!.gender;
        notifyListeners();
      } else {
        throw ('Anda tidak terautentikasi');
      }
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengambil data user. Silahkan coba lagi.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      Get.toNamed('/login');
    }
  }

  Future<void> getImageFromGallery() async {
    if (await Permission.storage.request().isGranted) {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, maxHeight: 500, imageQuality: 50);
      if (image != null) {
        _image = File(image.path);
        notifyListeners();
      }
    } else if (await Permission.manageExternalStorage.request().isGranted) {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, maxHeight: 500, imageQuality: 50);
      if (image != null) {
        _image = File(image.path);
        notifyListeners();
      }
    }
  }

  Future<void> pickImageFromCamera() async {
    if (await Permission.camera.request().isGranted) {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.camera, maxHeight: 500, imageQuality: 50);
      if (image != null) {
        _image = File(image.path);
        notifyListeners();
      }
    }
  }

  Future<void> updateProfile(String name, String email, String gender) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _settingService.updateProfile(
        name,
        email,
        gender,
        _image?.path,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Profile berhasil diupdate',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        final data = response.data['data'];
        user = UserModel.fromJson(data);
        _selectedValue = user!.gender;
        notifyListeners();
      } else {
        Get.snackbar(
          'Terjadi Kesalahan',
          'Tidak dapat mengupdate profile. Silahkan coba lagi.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengupdate profile. Silahkan coba lagi atau Tunggu beberapa saat.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      _isLoading = false;
      notifyListeners();
      print(e);
    }
  }

  Future<void> updateSelectedValue(String value) async {
    _selectedValue = value;
    notifyListeners();
  }

  Future<void> getFaqs() async {
    try {
      final response = await _settingService.getFaq();

      if (response.statusCode == 200) {
        final data = response.data['data'];
        faqs = List<FaqModel>.from(data.map((json) => FaqModel.fromJson(json)));
      } else {
        throw ('Terjadi kesalahan dalam pengambilan data faq');
      }
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengambil data faq. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _settingService.changePassword(newPassword);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Password berhasil diubah',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Terjadi Kesalahan',
          'Tidak dapat mengubah password. Silahkan coba lagi.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengubah password. Silahkan coba lagi atau Tunggu beberapa saat.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      _isLoading = false;
      notifyListeners();
      print(e);
    }
  }
}
