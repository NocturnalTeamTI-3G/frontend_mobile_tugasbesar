import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  final Dio _dio = Dio();

  HomeService() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<Response> getHistoryLast() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.get('/api/histories/last',
        options: Options(headers: {
          'Authorization': '$token',
        }));

    return response;
  }
}
