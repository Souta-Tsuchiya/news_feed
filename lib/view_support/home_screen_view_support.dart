import 'package:flutter/material.dart';
import 'package:news_feed/view/pages/about_us_page/about_us_page.dart';
import 'package:news_feed/view/pages/head_line_page/head_line_page.dart';
import 'package:news_feed/view/pages/news_list_page/news_list_page.dart';

class HomeScreenViewSupport extends ChangeNotifier{
  final List pages = [
    HeadLinePage(),
    NewsListPage(),
    AboutUsPage(),
  ];

  int currentIndex = 0;

  void changeNavigationBar(int index) {
    currentIndex = index;
    notifyListeners();
  }
}