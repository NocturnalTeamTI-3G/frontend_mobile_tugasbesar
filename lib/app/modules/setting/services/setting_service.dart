import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  final Dio _dio = Dio();

  SettingService() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }

  Future<Response> updateProfile(
      String name, String email, String gender, String? profileImg) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Response response;

    final formData = FormData.fromMap({
      'username': name,
      'email': email,
      'gender': gender,
      if (profileImg != null)
        'profile_img': await MultipartFile.fromFile(profileImg),
    });
    response = await _dio.patch(
      '/api/users/current',
      options: Options(headers: {
        'Authorization': '$token',
      }),
      data: formData,
    );
    return response;
  }

  Future<Response> changePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Response response;
   
    response = await _dio.patch(
      '/api/users/current',
      options: Options(headers: {
        'Authorization': '$token',
      }),
      data: {
        'password': password,
      },
    );
    return response;
  }

  Future<Response> getFaq() async {
    final response = await _dio.get('/api/faqs');
    return response;
  }
}
