import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraServices {
  final Dio _dio = Dio();

  CameraServices() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> ScanDisease(String imagePath) async {
    final formData = FormData.fromMap({
      'face_img': await MultipartFile.fromFile(imagePath),
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.post('/api/histories',
        data: formData,
        options: Options(headers: {
          'Authorization': '$token',
        }));
    return response;
  }
}
