import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/news/artikel_model.dart';
import 'package:frontend_mobile_tugasbesar/app/models/product/product_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/home/services/home_service.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/services/news_service.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/services/product_service.dart';
import 'package:get/get.dart';

class HomeProvider extends ChangeNotifier {
  Map<String, dynamic>? _history;
  Map<String, dynamic>? get history => _history;
  List<ProductModel>? _products;
  List<ProductModel>? get products => _products;
  List<ArtikelModel>? _news;
  List<ArtikelModel>? get news => _news;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductService _productService = ProductService();
  HomeService _homeService = HomeService();
  NewsService _newsService = NewsService();

  Future<void> setHistory() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _homeService.getHistoryLast();

      if (response.statusCode == 200) {
        final data = response.data['data'];
        _history = {
          "id": data['id'],
          "userId": data['userId'],
          "disease": data['disease'],
          "description_disease": data['description_disease'],
          "solution_disease": data['solution_disease'],
          "face_img": data['face_img'],
          "created_at": data['created_at']
        };
      } else {
        Get.snackbar(
          'Error',
          'Failed to get history',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error setHistory: $e');
    }
  }

  Future<void> setProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _productService.getAllProducts();

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final product = List<ProductModel>.from(
          data.map(
            (json) => ProductModel.fromJson(json),
          ),
        );
        _products = product.take(5).toList();
      } else {
        Get.snackbar(
          'Error',
          'Failed to get products',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get products',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
      print('Error setProducts: $e');
    }
  }

  Future<void> setNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _newsService.getAllArticles();

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final news = List<ArtikelModel>.from(
          data.map(
            (json) => ArtikelModel.fromJson(json),
          ),
        );
        _news = (news..shuffle(Random())).take(5).toList();
      } else {
        Get.snackbar(
          'Error',
          'Failed to get news',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get news',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
      print('Error setNews: $e');
    }
  }
}
