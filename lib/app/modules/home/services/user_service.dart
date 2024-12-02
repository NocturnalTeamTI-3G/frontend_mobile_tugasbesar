import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final Dio _dio = Dio();

  UserService() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }

  Future<Response> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // print(token);

    final response = await _dio.get('/api/users/current',
        options: Options(headers: {
          'Authorization': '$token',
        }));

    // print(response);
    return response;
  }
}
