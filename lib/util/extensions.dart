import 'package:news_feed/model/database/database_manager.dart';
import 'package:news_feed/model/news_models/news_model.dart';

extension ConvertToDbArticles on List<Article> {
  List<DbArticle> toDbArticles(List<Article> articles) {
    var dbArticles = <DbArticle>[];
    articles.forEach((article) {
      dbArticles.add(DbArticle(
        author: article.author ?? "",
        title: article.title ?? "",
        description: article.description ?? "",
        url: article.url ?? "",
        urlToImage: article.urlToImage ?? "",
        publishedAt: article.publishedAt ?? "",
        content: article.content ?? "",
      ));
    });
    return dbArticles;
  }
}

extension ConvertToNewsArticles on List<DbArticle> {
  List<Article> toNewsArticles(List<DbArticle> dbArticles) {
    var newsArticles = <Article>[];
    dbArticles.forEach((dbArticle) {
      newsArticles.add(Article(
        author: dbArticle.author,
        title: dbArticle.title,
        description: dbArticle.description,
        url: dbArticle.url,
        urlToImage: dbArticle.urlToImage,
        publishedAt: dbArticle.publishedAt,
        content: dbArticle.content,
      ));
    });
    return newsArticles;
  }
}