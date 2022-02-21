import 'package:flutter/material.dart';
import 'package:news_feed/model/news_models/news_model.dart';
import 'package:news_feed/util/constant.dart';
import 'package:news_feed/view/news_web_page_screen.dart';
import 'package:news_feed/view/pages/news_list_page/components/article_tile.dart';
import 'package:news_feed/view_model/news_list_page_view_model.dart';
import 'package:provider/provider.dart';

import 'components/category_chips.dart';
import 'components/search_bar.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NewsListPageViewModel>();
    if (viewModel.loadStatus != LoadStatus.LOADING && viewModel.articles.isEmpty) {
      Future(() => {
            viewModel.onRefresh(),
          });
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchBar(
                wordSearch: (value) => _wordSearchNews(context, value),
              ),
              Selector<NewsListPageViewModel, int>(
                selector: (context, viewSupport) => viewSupport.selectedCategoryChipIndex,
                builder: (context, selectedCategoryChipIndex, child) {
                  return CategoryChips(
                    onCategorySelected: (index) => _categorySelectNews(context, index),
                  );
                },
              ),
              Expanded(
                child: Selector<NewsListPageViewModel, LoadStatus>(
                  selector: (context, viewModel) => viewModel.loadStatus,
                  builder: (context, isLoading, child) {
                    return viewModel.loadStatus == LoadStatus.LOADING
                        ? Center(child: CircularProgressIndicator())
                        : Selector<NewsListPageViewModel, List<Article>>(
                            selector: (context, viewModel) => viewModel.articles,
                            builder: (context, articles, child) {
                              return ListView.builder(
                                itemCount: articles.length,
                                itemBuilder: (context, int index) => ArticleTile(
                                  article: articles[index],
                                  onArticleClicked: (article) => _openWeb(context, article),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          backgroundColor: Colors.lightGreenAccent.withOpacity(0.7),
          tooltip: "更新",
          onPressed: () => _onRefresh(context),
        ),
      ),
    );
  }

  _onRefresh(BuildContext context) {
    final viewModel = context.read<NewsListPageViewModel>();
    viewModel.onRefresh();
  }

  _wordSearchNews(BuildContext context, String searchWord) {
    final viewModel = context.read<NewsListPageViewModel>();
    viewModel.wordSearchNews(searchWord);
  }

  _categorySelectNews(BuildContext context, int index) {
    final viewModel = context.read<NewsListPageViewModel>();
    viewModel.categorySelectNews(index);
  }

  _openWeb(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsWebPageScreen(article: article),
      ),
    );
  }
}
