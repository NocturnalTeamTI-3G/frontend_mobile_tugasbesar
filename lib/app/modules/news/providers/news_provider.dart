import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/services/news_service.dart';
import 'package:get/get.dart';
import '../../../models/news/artikel_model.dart';

class NewsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final NewsService _newsService = NewsService();
  List<ArtikelModel> listAllArticle = [];
  List<ArtikelModel> listArticle = [];
  List<ArtikelModel> carouselArticle = [];
  List<ArtikelModel> newestArticle = [];
  List<ArtikelModel> recommendedArticle = [];

  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  ValueNotifier<int> get currentPage => _currentPage;

  int _likeCount = 0;
  int get likeCount => _likeCount;

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void setCurrentPage(int index) {
    _currentPage.value = index;
  }

  void searchArticle(String query) {
    if (query.isEmpty) {
      listArticle = listAllArticle;
    } else {
      listArticle = listAllArticle
          .where((element) =>
              element.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  Future<void> getAllArticles() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _newsService.getAllArticles();

      if (response.statusCode == 200) {
        final data = response.data['data'];
        listAllArticle = List<ArtikelModel>.from(
            data.map((json) => ArtikelModel.fromJson(json)));
        listArticle = listAllArticle;
        carouselArticle = listAllArticle.take(3).toList();
        newestArticle = listAllArticle.take(5).toList();
      } else {
        throw ('Terjadi kesalahan dalam pengambilan data artikel');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengambil data artikel. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ArtikelModel?> getArticleById(int id) async {
    try {
      ArtikelModel article;

      final response = await _newsService.getArticleById(id);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        article = ArtikelModel.fromJson(data);
        recommendedArticle = listAllArticle
            .where((element) =>
                element.category == article.category &&
                element.id != article.id)
            .toList()
          ..shuffle()
          ..take(3).toList();
        _likeCount = article.likes;
        _isLiked = data['isLiked'];
      } else {
        throw ('Artikel tidak ditemukan');
      }
      return article;
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengambil data artikel. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  Future<void> likeArticle(int id) async {
    if (_isLiked) {
      _isLiked = false;
    } else {
      _isLiked = true;
    }

    try {
      final response = await _newsService.likeArticle(id, _isLiked);

      if (response.statusCode == 200) {
        final newResp = await _newsService.getArticleById(id);
        final data = newResp.data['data'];
        _likeCount = data['likes'];
      }
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat memberikan like artikel. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
