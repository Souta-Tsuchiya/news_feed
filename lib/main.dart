import 'package:flutter/material.dart';
import 'package:news_feed/di/providers.dart';
import 'package:news_feed/util/constant.dart';
import 'package:news_feed/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "シンプルニュースアプリ",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: BoldFont),
    );
  }
}
