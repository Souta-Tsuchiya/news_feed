import 'package:drift/drift.dart';
import 'package:news_feed/model/database/database_manager.dart';

part 'database_access_object.g.dart';

@DriftAccessor(tables: [DbArticles])
class DatabaseAccessObject extends DatabaseAccessor<DataBaseManager> with _$DatabaseAccessObjectMixin {
  DatabaseAccessObject(DataBaseManager attachedDatabase) : super(attachedDatabase);

  Future clearDB() => delete(dbArticles).go();

  Future insertDB(List<DbArticle> articles) async {
    await batch((batch) {
      batch.insertAll(dbArticles, articles);
    });
  }

  Future<List<DbArticle>> get readDb => select(dbArticles).get();

  Future<List<DbArticle>> clearInsertReadDb(List<DbArticle> articles) => transaction(() async{
    await clearDB();
    await insertDB(articles);
    return await readDb;
  });
}
