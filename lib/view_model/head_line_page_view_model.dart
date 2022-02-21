import 'package:flutter/material.dart';
import 'package:news_feed/model/news_models/news_model.dart';
import 'package:news_feed/model/news_repository.dart';
import 'package:news_feed/util/constant.dart';

class HeadLinePageViewModel extends ChangeNotifier {
  final NewsRepository newsRepository;

  HeadLinePageViewModel({required this.newsRepository});

  List<Article> _articles = [];
  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  void onRefresh() async{
    await newsRepository.onHeadLineRefresh();
  }

  onRepositoryUpdated(NewsRepository repository) {
    _articles = repository.headLineArticles;
    _loadStatus = repository.loadStatus;
    notifyListeners();
  }
}