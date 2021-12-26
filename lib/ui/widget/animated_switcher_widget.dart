import 'package:flutter/material.dart';

class ScaleAnimatedSwitcher extends StatelessWidget {

  final Widget child;

  const ScaleAnimatedSwitcher(this.child);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => ScaleTransition(child: child, scale: animation),
      child: child,
    );
  }
}

class ShowHideAnimatedSwitcher extends StatelessWidget {

  final bool isShow;
  final Widget child;

  const ShowHideAnimatedSwitcher({this.isShow, this.child});

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedSwitcher(isShow ? child : SizedBox.shrink());
  }
}
