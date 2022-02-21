import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/model/news_models/news_model.dart';
import 'package:news_feed/util/constant.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  final ValueChanged onArticleClicked;

  ArticleTile({required this.article, required this.onArticleClicked});

  @override
  Widget build(BuildContext context) {
    final isInvalidUrl = article.urlToImage != null ? article.urlToImage!.startsWith("http") : false;
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(8.0),
        ),
      ),
      child: InkWell(
        onTap: () => onArticleClicked(article),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: (article.urlToImage == null || article.urlToImage == "" || !isInvalidUrl)
                  ? const Icon(Icons.broken_image)
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage!,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? "",
                      style: textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      article.publishedAt ?? "",
                      style: textTheme.overline!.copyWith(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      article.description ?? "",
                      style: textTheme.bodyText2!.copyWith(fontFamily: RegularFont),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
