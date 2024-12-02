import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();

  AuthService() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }

  Future<Response> login(String email, String password) async {
    final response = await _dio.post('/api/users/login', data: {
      'email': email,
      'password': password,
    });

    return response;
  }

  Future<Response> register(
      String email, String password, String name, String gender) async {
    final response = await _dio.post('/api/users', data: {
      'email': email,
      'password': password,
      'username': name,
      'role_id': 1,
      'profile_img': 'null',
      'gender': gender,
    });
    return response;
  }

  Future<String?> forgotPassword(String email, String password) async {
    return null;
  }

  Future<Response> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.delete('/api/users/current',
        options: Options(headers: {
          'Authorization': '$token',
        }));
    return response;
  }

  Future<Response> sendEmail(String email) async {
    final response = await _dio.post(
      '/api/forgot-password',
      data: {
        'email': email,
      },
    );
    return response;
  }

  Future<Response> checkToken(String token) async {
    final response = await _dio.post(
      '/api/forgot-password/check',
      data: {
        'token': token,
      },
    );

    return response;
  }

  Future<Response> updatePassword(String password, String email) async {
    final response = await _dio.post(
      '/api/forgot-password/update?email=$email',
      data: {
        'password': password,
      },
    );
    return response;
  }
}
