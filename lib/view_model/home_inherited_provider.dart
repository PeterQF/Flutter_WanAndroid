import 'package:flutter/material.dart';

class HomeInheritedProvider<T> extends InheritedWidget {

  final T data;

  HomeInheritedProvider({@required this.data, @required Widget child}): super(child: child);

  @override
  bool updateShouldNotify(HomeInheritedProvider<T> oldWidget) {
    return true;
  }
}