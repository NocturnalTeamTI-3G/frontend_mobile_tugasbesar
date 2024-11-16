import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsService {
  final Dio _dio = Dio();

  NewsService() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Response> getAllArticles() async {
    final response = await _dio.get('/api/posts');

    return response;
  }

  Future<Response> getArticleById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _dio.get('/api/posts/$id?post_clicked=true',
        options: Options(headers: {'Authorization': '$token'}));

    return response;
  }

  Future<Response> likeArticle(int id, bool like) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    final response = await _dio.get('/api/posts/$id/likes?like=$like',
        options: Options(headers: {'Authorization': '$token'}));

    return response;
  }
}
