import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/model/news_models/news_model.dart';
import 'package:news_feed/view/pages/head_line_page/components/page_transformer.dart';

class HeadLinePageItem extends StatelessWidget {
  final Article article;
  final ValueChanged onClick;
  final PageVisibility pageVisibility;

  HeadLinePageItem({required this.article, required this.onClick, required this.pageVisibility});

  @override
  Widget build(BuildContext context) {
    final isInvalidUrl = article.urlToImage != null ? article.urlToImage!.startsWith("http") : false;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2.0,
      child: InkWell(
        onTap: () => onClick(article),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black26, Colors.black87]),
              ),
              child: (article.urlToImage == null || article.urlToImage == "" || !isInvalidUrl)
                  ? Icon(Icons.broken_image)
                  : CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              bottom: 64.0,
              right: 32.0,
              left: 32.0,
              child: Opacity(
                opacity: pageVisibility.visibleFraction,
                child: Transform(
                  alignment: Alignment.topLeft,
                  transform: Matrix4.translationValues(pageVisibility.pagePosition * 300, -pageVisibility.pagePosition * 300, 0.0),
                  child: Text(
                    article.title ?? "",
                    style: textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
