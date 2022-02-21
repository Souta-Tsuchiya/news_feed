import 'package:flutter/material.dart';
import 'package:news_feed/data/news_category.dart';
import 'package:news_feed/view_model/news_list_page_view_model.dart';
import 'package:provider/provider.dart';

class CategoryChips extends StatelessWidget {
  final ValueChanged onCategorySelected;

  CategoryChips({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<NewsListPageViewModel>();

    return Wrap(
      spacing: 3.0,
      children: List<Widget>.generate(newsCategories.length, (int index) {
        return ChoiceChip(
          label: Text(newsCategories[index].jpName),
          selected: viewModel.selectedCategoryChipIndex == index,
          onSelected: (bool isSelected) {
            if(isSelected) {
              onCategorySelected(index);
            }else{
              return null;
            }

          },
        );
      }).toList(),
    );
  }

}
