import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/services/news_service.dart';
import '../../../models/news/artikel_model.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  int _currentPage = 0;
  int get currentPage => _currentPage;

  List<ArtikelType> listArtikel = [];
  List<ArtikelType> listCarousel = [];

  NewsProvider() {
    _fetchArticles();
  }

  void _fetchArticles() {
    // listArtikel = await NewsService().getArticles();
    listArtikel = _newsService.getAllArticles();
    listCarousel = listArtikel.sublist(0, 3);
    notifyListeners();
  }

  void setCurrentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
