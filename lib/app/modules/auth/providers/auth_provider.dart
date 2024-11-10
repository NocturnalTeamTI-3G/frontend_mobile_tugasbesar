import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _token;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _token != null;

  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _authService.login(email, password);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        _token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setBool('isLoggedIn', true);

        Get.offAllNamed('/main');
      } else {
        Get.snackbar(
          'Terjadi Kesalahan',
          'Email atau password salah',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.snackbar(
        'Terjadi Kesalahan',
        'Silahkan coba lagi atau hubungi admin',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> completeBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoardingComplete', true);
    Get.toNamed('/main');
  }

  Future<void> register(
      String email, String password, String name, String gender) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response =
          await _authService.register(email, password, name, gender);
      if (response.statusCode == 200) {
        Get.offAllNamed('/login');
      } else {
        Get.snackbar(
          'Email Sudah Ada',
          'Silahkan Gunakan Email Yang Lain',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Get.snackbar(
        'Terjadi Kesalahan',
        'Silahkan coba lagi atau hubungi admin',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();
  }

  
}
