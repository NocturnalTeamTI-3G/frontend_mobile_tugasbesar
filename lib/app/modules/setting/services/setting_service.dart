import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  final Dio _dio = Dio();

  SettingService() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> updateProfile(
      String name, String email, String gender, String profileImg) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.patch(
      '/api/users/current',
      options: Options(headers: {
        'Authorization': '$token',
      }),
      data: {
        'username': name,
        'email': email,
        'gender': gender,
        'profile_img': profileImg,
      },
    );

    return response;
  }
}
