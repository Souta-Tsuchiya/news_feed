import 'package:flutter/material.dart';
import 'package:news_feed/view_support/home_screen_view_support.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeScreenViewSupport>();

    return Scaffold(
      body: Selector<HomeScreenViewSupport, int>(
        selector: (context, viewModel) => viewModel.currentIndex,
        builder: (context, currentIndex, child) {
          return viewModel.pages[currentIndex];
        },
      ),
      bottomNavigationBar: Selector<HomeScreenViewSupport, int>(
        selector: (context, viewModel) => viewModel.currentIndex,
        builder: (context, currentIndex, child) {
          return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => _changeNavigationBar(context, index),
            items: const [
              BottomNavigationBarItem(
                label: "トップニュース",
                icon: const Icon(Icons.highlight),
              ),
              BottomNavigationBarItem(
                label: "ニュース一覧",
                icon: const Icon(Icons.list),
              ),
              BottomNavigationBarItem(
                label: "お遊び",
                icon: const Icon(Icons.devices_other),
              ),
            ],
          );
        },
      ),
    );
  }

  _changeNavigationBar(BuildContext context, int index) {
    final viewModel = context.read<HomeScreenViewSupport>();
    viewModel.changeNavigationBar(index);
  }
}
