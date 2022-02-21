import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/model/news_models/news_model.dart';
import 'package:news_feed/model/news_repository.dart';
import 'package:news_feed/util/constant.dart';

class NewsListPageViewModel extends ChangeNotifier {
  final NewsRepository newsRepository;

  NewsListPageViewModel({required this.newsRepository});

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  int _selectedCategoryChipIndex = 0;
  int get selectedCategoryChipIndex => _selectedCategoryChipIndex;

  void onRefresh() async{
    await newsRepository.onNewsListRefresh();
  }

  void wordSearchNews(String searchWord) async{
    await newsRepository.wordSearchNews(searchWord);
  }

  void categorySelectNews(int categoryIndex) async{
    await newsRepository.categorySelectNews(categoryIndex);
  }

  onRepositoryUpdated(NewsRepository repository) {
    _articles = repository.newsListArticles;
    _loadStatus = repository.loadStatus;
    _selectedCategoryChipIndex = repository.selectedCategoryChipIndex;
    notifyListeners();
  }
}