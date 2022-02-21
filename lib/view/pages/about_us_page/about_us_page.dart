import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:news_feed/view_support/about_us_page_view_support.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AboutUsPageViewSupport>();

    return SafeArea(
      child: Scaffold(
        body: Selector<AboutUsPageViewSupport, bool>(
          selector: (context, viewModel) => viewModel.isSelected,
          builder: (context, isSelected, child) {
            return Center(
              child: AnimatedContainer(
                width: viewModel.isSelected ? 300 : 50,
                height: viewModel.isSelected ? 200 : 30,
                child: AutoSizeText(
                  "AboutUsPage",
                  style: TextStyle(fontSize: 40.0),
                  minFontSize: 6.0,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
                alignment: viewModel.isSelected ? Alignment.center : Alignment.topCenter,
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellowAccent,
          child: Icon(Icons.play_arrow),
          onPressed: () => _playAnime(context, viewModel.isSelected),
          tooltip: "アニメーション",
        ),
      ),
    );
  }

  _playAnime(BuildContext context, bool isSelected) {
    final viewModel = context.read<AboutUsPageViewSupport>();
    viewModel.playAnime(isSelected);
  }
}
