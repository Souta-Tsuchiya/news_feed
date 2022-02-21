import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged wordSearch;
  SearchBar({required this.wordSearch});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchBarTextController = TextEditingController();

    return Card(
      elevation: 2.0,
      shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          maxLines: 1,
          controller: searchBarTextController,
          decoration: const InputDecoration(
            icon: const Icon(Icons.search),
            hintText: "検索ワードを入れて下さい",
            border: InputBorder.none
          ),
          onSubmitted: wordSearch,
        ),
      ),
    );
  }
}
