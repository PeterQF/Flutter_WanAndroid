// 基础请求
import 'package:flutter_wan_android/http/core/wan_url_constants.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  // eg: https://wanandroid.com/wxarticle/chapters/json
  // eg: https://www.wanandroid.com/article/list/0/json?cid=60

  // 路径,eg: /article/list/0/json
  var pathParams;
  var useHttps = true;

  String authority() => baseAuthority;
  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    // http和https的切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print("url: ${uri.toString()}");
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();
  // 添加参数
  BaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  Map<String, String> header = Map();
  // 添加Header
  BaseRequest addHeader(String key, Object value) {
    header[key] = value.toString();
    return this;
  }
}
