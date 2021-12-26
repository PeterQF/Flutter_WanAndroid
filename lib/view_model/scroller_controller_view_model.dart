import 'package:flutter/material.dart';

class TitleBarScrollViewModel with ChangeNotifier {
  ScrollController _scrollController;

  double _height;

  bool _isShow = false;

  ScrollController get scrollController => _scrollController;

  bool get isShow => _isShow;

  TitleBarScrollViewModel(this._scrollController, {double height: 200}) {
    _height = height;
  }

  init() {
    _scrollController.addListener(() {
      if (_scrollController.offset > _height && !_isShow) {
        _isShow = true;
        notifyListeners();
      } else if (_scrollController.offset < _height && _isShow) {
        _isShow = false;
        notifyListeners();
      }
    });
  }
}
