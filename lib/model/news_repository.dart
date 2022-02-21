import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_feed/data/news_category.dart';
import 'package:news_feed/model/database/database_access_object.dart';
import 'package:http/http.dart' as http;
import 'package:news_feed/model/news_models/news_model.dart';
import 'package:news_feed/util/constant.dart';
import 'package:news_feed/util/extensions.dart';

class NewsRepository extends ChangeNotifier{
  final DatabaseAccessObject dao;
  http.Response? response;
  List<Article> results = [];

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  List<Article> _headLineArticles = [];
  List<Article> get headLineArticles => _headLineArticles;

  List<Article> _newsListArticles = [];
  List<Article> get newsListArticles => _newsListArticles;

  int _selectedCategoryChipIndex = 0;
  int get selectedCategoryChipIndex => _selectedCategoryChipIndex;

  NewsRepository({required this.dao});

  static const BASE_URL = "https://newsapi.org/v2/top-headlines?country=jp";
  static const API_KEY = "&apiKey=cc6c5d9614b34500a7707b61fc9cc179";

  Future<void> onHeadLineRefresh() async {
    _loadStatus = LoadStatus.LOADING;
    notifyListeners();

    final requestUrl = Uri.parse(BASE_URL + "&pageSize=7" + API_KEY);
    response = await http.get(requestUrl);

    if(response?.statusCode == 200) {
      final responseBody = response!.body;
      // results = News.fromJson(jsonDecode(responseBody)).articles;
      _headLineArticles = await clearInsertReadDb(News.fromJson(jsonDecode(responseBody)).articles);
      _loadStatus = LoadStatus.DONE;
    }else{
      _loadStatus = LoadStatus.ERROR;
      throw Exception("Failed to load album");
    }

    notifyListeners();
  }

  Future<void> onNewsListRefresh() async {
    _selectedCategoryChipIndex = 0;
    _loadStatus = LoadStatus.LOADING;
    notifyListeners();

    final requestUrl = Uri.parse(BASE_URL + "&pageSize=5" + API_KEY);
    response = await http.get(requestUrl);

    if(response?.statusCode == 200) {
      final responseBody = response!.body;
      // results = News.fromJson(jsonDecode(responseBody)).articles;
      _newsListArticles = await clearInsertReadDb(News.fromJson(jsonDecode(responseBody)).articles);
      _loadStatus = LoadStatus.DONE;
    }else{
      _loadStatus = LoadStatus.ERROR;
      throw Exception("Failed to load album");
    }

    notifyListeners();
  }

  Future<void> wordSearchNews(String keyword) async {
    _loadStatus = LoadStatus.LOADING;
    notifyListeners();

    final requestUrl = Uri.parse(BASE_URL + "&q=$keyword&pageSize=10" + API_KEY);
    response = await http.get(requestUrl);

    if(response?.statusCode == 200) {
      final responseBody = response!.body;
      _newsListArticles = await clearInsertReadDb(News.fromJson(jsonDecode(responseBody)).articles);
      _loadStatus = LoadStatus.DONE;
    }else{
      _loadStatus = LoadStatus.ERROR;
      throw Exception("Failed to load album");
    }

    notifyListeners();
  }

  Future<void> categorySelectNews(int categoryIndex) async {
    _selectedCategoryChipIndex = 0;
    _selectedCategoryChipIndex = categoryIndex;
    _loadStatus = LoadStatus.LOADING;
    notifyListeners();

    final requestUrl =
        Uri.parse(BASE_URL + "&category=${newsCategories[categoryIndex].enName}&pageSize=5" + API_KEY);
    response = await http.get(requestUrl);

    if(response?.statusCode == 200) {
      final responseBody = response!.body;
      _newsListArticles = await clearInsertReadDb(News.fromJson(jsonDecode(responseBody)).articles);
      _loadStatus = LoadStatus.DONE;
    }else{
      _loadStatus = LoadStatus.ERROR;
      throw Exception("Failed to load album");
    }

    notifyListeners();
  }

  Future<List<Article>> clearInsertReadDb(List<Article> articles) async{
    final dbArticles = await dao.clearInsertReadDb(articles.toDbArticles(articles));

    return dbArticles.toNewsArticles(dbArticles);
  }
}
