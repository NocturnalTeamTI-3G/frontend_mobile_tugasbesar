import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  final Dio _dio = Dio();

  HistoryService() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.get('/api/histories',
        options: Options(headers: {
          'Authorization': '$token',
        }));

    return response;
  }

  Future<Response> getHistoryById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.get('/api/histories/$id',
        options: Options(headers: {
          'Authorization': '$token',
        }));

    return response;
  }
}
