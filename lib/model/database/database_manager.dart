import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:news_feed/model/database/database_access_object.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_manager.g.dart';

class DbArticles extends Table {
  TextColumn get author => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishedAt => text()();
  TextColumn get content => text()();
}

@DriftDatabase(tables: [DbArticles], daos: [DatabaseAccessObject])
class DataBaseManager extends _$DataBaseManager{
  DataBaseManager() : super(_openConnection());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'news.db'));
    return NativeDatabase(file);
  });
}