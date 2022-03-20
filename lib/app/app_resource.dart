import 'package:flutter/material.dart';

class ImageHelper {
  static String loadAssets(String path) {
    return "assets/" + path;
  }

  static Image loadLocalImage(String path, double width, double height,
      {BoxFit fit = BoxFit.cover}) {
    return Image.asset(
      loadAssets(path),
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget loadNetImage(String url, double width, double height,
      {String placeholder = 'image/image_placeholder.png',
      BoxFit fit = BoxFit.cover}) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/' + placeholder,
      image: url,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
