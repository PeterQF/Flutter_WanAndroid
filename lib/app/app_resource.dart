import 'package:flutter/material.dart';

class ImageHelper {
  static String loadAssets(String path) {
    return "assets/" + path;
  }

  static Image loadNetImage(
      String url, String placeholder, double width, double height) {
    if (url == null || url.isEmpty) {
      return Image.asset(loadAssets(placeholder));
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
