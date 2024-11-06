import 'package:flutter/material.dart';
import '../../../models/news/artikel_model.dart';

class NewsProvider extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  List<ArtikelType> listArtikel = ArtikelData().getAllArticles();
  List<ArtikelType> listCarousel = ArtikelData().getAllArticles().take(3).toList();

  void setCurrentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
