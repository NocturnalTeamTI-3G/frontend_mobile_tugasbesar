import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/auth/services/auth_service.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoading = false;
  String? _token;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _token != null;

  AuthProvider() {
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      _token = token;
      notifyListeners();
    }
  }

  Future<void> signUpWithGoogle() async {
    await _googleSignIn.signOut();
    try {
      _isLoading = true;
      notifyListeners();
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        String gender = "Laki-laki";
        String password = "defaultPassword123";

        final response = await _authService.register(
            user.email,
            password,
            user.displayName ?? user.email.split('@')[0],
            gender,
            user.photoUrl ?? 'null');

        if (response.statusCode == 200) {
          Get.snackbar(
            'Berhasil',
            'Registrasi Berhasil, Silahkan Login',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed('/login');
        } else {
          throw Exception('Google Sign-In Error');
        }
      } else {
        throw Exception('Google Sign-In Error');
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Silahkan coba lagi atau hubungi admin',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint("Google Sign-In Error: $error");
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    await _googleSignIn.signOut();
    try {
      _isLoading = true;
      notifyListeners();
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        String password = "defaultPassword123";

        final response = await _authService.login(user.email, password);
        if (response.statusCode == 200) {
          final data = response.data['data'];
          _token = data['token'];

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', _token!);
          await prefs.setBool('isLoggedIn', true);

          Get.offAllNamed(AppRouters.main);
        } else {
          Get.snackbar(
            'Akun Tidak Ditemukan',
            'Pastikan email dan password yang Anda masukkan sudah benar.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        throw Exception('Google Sign-In Error');
      }

      _isLoading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        Get.snackbar(
          'Akun Tidak Ditemukan',
          'Pastikan email dan password yang Anda masukkan sudah benar.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Terjadi Kesalahan',
          'Silahkan coba lagi atau hubungi admin',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Silahkan coba lagi atau hubungi admin',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint("Google Sign-In Error: $error");
      _isLoading = false;
      notifyListeners();
    }
  }

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

        Get.offAllNamed(AppRouters.main);
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
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        Get.snackbar(
          'Terjadi Kesalahan',
          'Email atau password salah',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Terjadi Kesalahan',
          'Silahkan coba lagi atau hubungi admin',
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
    Get.toNamed(AppRouters.main);
  }

  Future<void> register(
      String email, String password, String name, String gender) async {
    try {
      _isLoading = true;
      notifyListeners();

      final image = 'null';

      final response =
          await _authService.register(email, password, name, gender, image);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Registrasi Berhasil, Silahkan Login',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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

  Future<void> updatePassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.updatePassword(password, email);

      if (response.statusCode == 200 && response.data['data']) {
        Get.snackbar(
          'Berhasil',
          'Password Berhasil Diubah',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        _isLoading = false;
        notifyListeners();
        Get.offAllNamed(AppRouters.login);
      } else {
        Get.snackbar(
          'Gagal',
          'Password Gagal Diubah',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Password Gagal Diubah, Silahkan Coba Lagi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendEmail(String email) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _authService.sendEmail(email);
      if (response.statusCode == 200) {
        final data = response.data['data']['email'];
        Get.snackbar(
          'Berhasil',
          'Email Berhasil Dikirim',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        _isLoading = false;
        notifyListeners();
        Get.offNamed(AppRouters.otp, arguments: data);
      } else {
        Get.snackbar(
          'Gagal',
          'Email Gagal Dikirim',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Email Gagal Dikirim',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyToken(String email, String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.checkToken(token);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data) {
          Get.snackbar(
            'Berhasil',
            'Kode OTP berhasil diverifikasi',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          _isLoading = false;
          notifyListeners();
          Get.offNamed(AppRouters.newPassword, arguments: email);
        } else {
          Get.snackbar(
            'Gagal',
            'Kode OTP gagal diverifikasi',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Kode OTP gagal diverifikasi, silahkan coba lagi',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }
}
