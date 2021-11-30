import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_wan_android/http/http_exception.dart';
import 'package:flutter_wan_android/http/http_response.dart';
import 'package:flutter_wan_android/http/default_http_transformer.dart';
import 'http_transformer.dart';

HttpResponse handleResponse(Response response,
    {HttpTransformer httpTransformer}) {
  httpTransformer ??= DefaultHttpTransformer.getInstance();

  // 返回异常
  if (response == null) {
    return HttpResponse.failureFromError();
  }

  // token失效
  if (_isTokenTimeout(response.statusCode)) {
    return HttpResponse.failureFromError(UnauthorisedException(
        message: response.statusMessage ?? "请先登录", code: response.statusCode));
  }

  // 接口调用成功
  if (_isRequestSuccess(response.statusCode)) {
    return httpTransformer.parse(response);
  } else {
    // 接口调用失败
    return HttpResponse.failure(
        errorMsg: response.statusMessage, errorCode: response.statusCode);
  }
}

/// 鉴权失败
bool _isTokenTimeout(int code) {
  return code == -1001;
}

/// 请求成功
bool _isRequestSuccess(int statusCode) {
  return (statusCode != null && statusCode >= 200 && statusCode < 300);
}

HttpException _parseException(Exception error) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return NetworkException(message: error.message);
      case DioErrorType.cancel:
        return CancelException(error.message);
      case DioErrorType.response:
        try {
          int errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return RequestException(message: "请求语法错误", code: errCode);
            case 401:
              return UnauthorisedException(message: "没有权限", code: errCode);
            case 403:
              return RequestException(message: "服务器拒绝执行", code: errCode);
            case 404:
              return RequestException(message: "无法连接服务器", code: errCode);
            case 405:
              return RequestException(message: "请求方法被禁止", code: errCode);
            case 500:
              return ServiceException(message: "服务器内部错误", code: errCode);
            case 502:
              return ServiceException(message: "无效的请求", code: errCode);
            case 503:
              return ServiceException(message: "服务器挂了", code: errCode);
            case 505:
              return UnauthorisedException(
                  message: "不支持HTTP协议请求", code: errCode);
            default:
              return UnknownException(error.message);
          }
        } on Exception catch (_) {
          return UnknownException(error.message);
        }
        break;
      case DioErrorType.other:
        if (error.error is SocketException) {
          return NetworkException(message: error.message);
        } else {
          return UnknownException(error.message);
        }
        break;
      default:
        return UnknownException(error.message);
    }
  } else {
    return UnknownException(error.toString());
  }
}
