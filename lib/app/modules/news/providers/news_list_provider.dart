import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/news/artikel_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/services/news_service.dart';

class NewsListProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<ArtikelType> listArtikel = [];

  NewsListProvider() {
    _fetchArticles();
  }
  
  void _fetchArticles() {
    listArtikel = _newsService.getAllArticles();
  }
}