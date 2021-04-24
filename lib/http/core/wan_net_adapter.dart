// 网络请求抽象层
import 'dart:convert';

import 'package:flutter_wan_android/http/request/wan_base_request.dart';

abstract class WanNetAdapter {
  Future<WanResponse<T>> send<T>(BaseRequest request);
}

class WanResponse<T> {
  WanResponse(
      {this.data, this.request, this.errorCode, this.errorMsg, this.extra});

  T data;
  BaseRequest request;
  int errorCode;
  String errorMsg;
  dynamic extra;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
