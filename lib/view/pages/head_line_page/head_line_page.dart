import 'package:flutter/material.dart';
import 'package:news_feed/model/news_models/news_model.dart';
import 'package:news_feed/util/constant.dart';
import 'package:news_feed/view/news_web_page_screen.dart';
import 'package:news_feed/view/pages/head_line_page/components/head_line_page_item.dart';
import 'package:news_feed/view/pages/head_line_page/components/page_transformer.dart';
import 'package:news_feed/view_model/head_line_page_view_model.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HeadLinePageViewModel>();

    if (viewModel.loadStatus != LoadStatus.LOADING && viewModel.articles.isEmpty) {
      Future(() {
        viewModel.onRefresh();
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Selector<HeadLinePageViewModel, LoadStatus>(
            selector: (context, viewModel) => viewModel.loadStatus,
            builder: (context, articles, child) {
              if (viewModel.loadStatus == LoadStatus.LOADING) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Selector<HeadLinePageViewModel, List<Article>>(
                  selector: (context, viewModel) => viewModel.articles,
                  builder: (context, articles, child) {
                    return PageTransformer(
                      pageViewBuilder:
                          (BuildContext context, PageVisibilityResolver visibilityResolver) {
                        return PageView.builder(
                          controller: PageController(
                            viewportFraction: 0.88,
                          ),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final pageVisibility = visibilityResolver.resolvePageVisibility(index);
                            return HeadLinePageItem(
                              article: articles[index],
                              onClick: (article) => _openWeb(context, article),
                              pageVisibility: pageVisibility,
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => _onRefresh(context),
        ),
      ),
    );
  }

  _onRefresh(BuildContext context) {
    final viewModel = context.read<HeadLinePageViewModel>();
    viewModel.onRefresh();
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
