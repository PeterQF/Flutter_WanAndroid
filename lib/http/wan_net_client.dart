import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_wan_android/db/wan_data_store.dart';
import 'package:flutter_wan_android/http/base_http.dart';
import 'http_exception.dart';

class WanNetClient extends BaseHttp {
  static const String _baseUrl = 'https://www.wanandroid.com';
  // 工厂模式
  factory WanNetClient() => _getInstance();
  
  static WanNetClient get getInstance => _getInstance();
  
  static WanNetClient _instance;
  
  WanNetClient._internal();
  
  static WanNetClient _getInstance() {
    if (_instance == null) {
      _instance = new WanNetClient._internal();
    }
    return _instance;
  }
  
  @override
  void init() {
    options.baseUrl = _baseUrl;
    interceptors
    ..add(WanApiInterceptor())
    ..add(CookieManager(PersistCookieJar(storage: FileStorage(WanDataStore.temporaryDirectory.path))));
  }
}

class WanApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    WanResponse wanResponse = WanResponse.fromJson(response.data);
    if(wanResponse.success) {
      response.data = wanResponse.data;
    } else {
      if(wanResponse.code == -1001) {
        // 如果cookie过期,需要清除本地存储的登录信息
        throw UnauthorisedException(message: wanResponse.message, code: wanResponse.code);
      } else {
        throw UnSuccessException(message: wanResponse.message, code: wanResponse.code);
      }
    }
    handler.next(response);
  }
}

class WanResponse extends BaseResponseData {
  
  bool get success => 0 == code;
  
  WanResponse.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}