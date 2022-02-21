import 'package:flutter/material.dart';

class AboutUsPageViewSupport extends ChangeNotifier{
  bool _isSelected = false;
  bool get isSelected => _isSelected;

  void playAnime(bool isSelected) {
    _isSelected = !isSelected;
    notifyListeners();
  }
}