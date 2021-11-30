// 必须是顶层函数
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_wan_android/utils/platform_utils.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    /// 初始化 加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(HeaderInterceptor());
    init();
  }

  void init();
}

/// 添加常用Header
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.connectTimeout = 1000 * 45;
    options.receiveTimeout = 1000 * 45;
    var appVersion = await PlatformUtils.getAppVersion();
    var version = Map()
      ..addAll({
        'appVersion': appVersion,
      });
    options.headers['version'] = version;
    options.headers['platform'] = Platform.operatingSystem;
    handler.next(options);
  }
}

/// 子类需要重写
abstract class BaseResponseData {
  int code = 0;
  String message;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.message, this.data});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data}';
  }
}