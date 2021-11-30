import 'dart:io';

import 'package:dio/dio.dart';

class HttpException implements Exception {
  final String _message;

  String get message => _message ?? this.runtimeType.toString();

  final int _code;

  int get code => _code ?? -1;

  HttpException([this._message, this._code]);

  @override
  String toString() {
    return "code = $code, message = $message";
  }
}

/// 客户端请求错误
class RequestException extends HttpException {
  RequestException({String message, int code}) : super(message, code);
}

/// 服务端响应错误
class ServiceException extends HttpException {
  ServiceException({String message, int code}) : super(message, code);
}

class UnknownException extends HttpException {
  UnknownException([String message]) : super(message);
}

class CancelException extends HttpException {
  CancelException([String message]) : super(message);
}

class NetworkException extends HttpException {
  NetworkException({String message, int code}) : super(message, code);
}

/// -1001
class UnauthorisedException extends HttpException {
  UnauthorisedException({String message, int code = -1001}) : super(message);
}

class ResponseException extends HttpException {
  dynamic data;
  ResponseException([this.data]) : super();
}

class UnSuccessException extends HttpException {
  UnSuccessException({String message, int code}) : super(message, code);
}

HttpException parseException(error) {
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
    if(error is UnauthorisedException) {
     return UnauthorisedException(message: error.message);
    }
    return UnknownException(error.toString());
  }
}