import 'package:flutter/material.dart';
import 'package:flutter_wan_android/provider/view_state_refresh_list_model.dart';
import 'package:flutter_wan_android/ui/page/user_page.dart';

class UserPageScrollViewModel extends ViewStateRefreshListModel {
  final BuildContext context;
  final AnimationController animationController;
  // 记录上一次移动的距离
  double preDy = 0;
  double _extraPicHeight = 0;
  double _maxPicHeight = 0;
  int lastChangeTime = 0;
  ScrollController _scrollController;
  ScrollController get scrollController => _scrollController;
  double get extraPicHeight => _extraPicHeight;
  Animation<double> anim;

  UserPageScrollViewModel(this.context, this.animationController, this._scrollController);

  updatePicHeight(changed) {
    // 假如手指点下的时候并没有移动，changed记录了当前手指点下的位置，那么不应该改变图片的大小
    if (preDy == 0) {
      preDy = changed;
    }
    // 防止多指点击立即伸缩
    // changed != 0 当_scrollController.offset > appbar高度时，updatePicHeight(0)，需要往下走更新_extraPicHeight
    if(changed != 0 && changed < _extraPicHeight) return;
    double extra = changed - preDy;
    _extraPicHeight += extra;
    // 防止高度出现负数
    if(_extraPicHeight < 0) _extraPicHeight = 0;
    if (_extraPicHeight > _maxPicHeight) _extraPicHeight = _maxPicHeight;
    preDy = changed;
    notifyListeners();
  }

  runAnimate() {
    anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
      ..addListener(() {
        _extraPicHeight = anim.value;
        notifyListeners();
      });
    preDy = 0;
    notifyListeners();
  }

  init() {
    double height = MediaQuery.of(context).size.height;
    print("height = $height");
    _maxPicHeight = MediaQuery.of(context).size.height / 3;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
    _scrollController.addListener(() {
      if(_scrollController.offset > userPageAppBarHeight - statusBarHeight) {
        updatePicHeight(0.0);
      }
    });
  }

  @override
  Future<List> loadData({int pageNum}) {
  }
}
