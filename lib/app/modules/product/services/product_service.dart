import 'package:dio/dio.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';

class ProductService {
  final Dio _dio = Dio();

  ProductService() {
    _dio.options.baseUrl = Api.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }

  Future<Response> getAllProducts() async {
    final response = await _dio.get('/api/products');

    return response;
  }

  Future<Response> getProductById(int id) async {
    final response = await _dio.get('/api/products/$id');

    return response;
  }
}