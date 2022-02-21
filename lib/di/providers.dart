import 'package:news_feed/model/database/database_access_object.dart';
import 'package:news_feed/model/database/database_manager.dart';
import 'package:news_feed/model/news_repository.dart';
import 'package:news_feed/view_support/about_us_page_view_support.dart';
import 'package:news_feed/view_model/head_line_page_view_model.dart';
import 'package:news_feed/view_support/home_screen_view_support.dart';
import 'package:news_feed/view_model/news_list_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
  ...viewSupports,
];

List<SingleChildWidget> independentModels = [
  Provider<DataBaseManager>(
    create: (context) => DataBaseManager(),
    dispose: (context, db) => db.close(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DataBaseManager, DatabaseAccessObject>(
    update: (context, dbManager, dao) => DatabaseAccessObject(dbManager),
  ),
  ChangeNotifierProvider<NewsRepository>(
    create: (context) => NewsRepository(
      dao: context.read<DatabaseAccessObject>(),
    ),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProxyProvider<NewsRepository, NewsListPageViewModel>(
    create: (context) => NewsListPageViewModel(
      newsRepository: context.read<NewsRepository>(),
    ),
    update: (context, repository, viewModel) => viewModel!..onRepositoryUpdated(repository),
  ),
  ChangeNotifierProxyProvider<NewsRepository, HeadLinePageViewModel>(
    create: (context) => HeadLinePageViewModel(
      newsRepository: context.read<NewsRepository>(),
    ),
    update: (context, repository, viewModel) => viewModel!..onRepositoryUpdated(repository),
  ),
];

List<SingleChildWidget> viewSupports = [
  ChangeNotifierProvider<HomeScreenViewSupport>(create: (context) => HomeScreenViewSupport()),
  ChangeNotifierProvider<AboutUsPageViewSupport>(create: (context) => AboutUsPageViewSupport()),
];