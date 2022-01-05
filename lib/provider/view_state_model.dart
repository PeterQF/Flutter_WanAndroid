import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/http/http_exception.dart';
import 'package:flutter_wan_android/utils/toast_utils.dart';
import 'package:flutter_wan_android/provider/view_state.dart';

class ViewStateModel extends ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  /// 根据状态构造
  ///
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  ViewStateModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.idle;

  /// ViewState
  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  /// ViewStateError
  ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  bool get isLoading => viewState == ViewState.loading;

  bool get isIdle => viewState == ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setLoading() {
    viewState = ViewState.loading;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  /// [e]分类Error和Exception两种
  /// setError(e, stackTrace)参数这样写默认是动态类型的dynamic
  void setError(e, stackTrace) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;
    String message;

    /// 见https://github.com/flutterchina/dio/blob/master/README-ZH.md#dioerrortype
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        // timeout
        errorType = ViewStateErrorType.netWorkError;
        message = e.error;
      } else if (e.type == DioErrorType.response) {
        // incorrect status, such as 404, 503...
        try {
          int errCode = e.response?.statusCode;
          switch (errCode) {
            case 400:
              message = "请求语法错误";
              break;
            case 401:
              message = "没有权限";
              break;
            case 403:
              message = "服务器拒绝执行";
              break;
            case 404:
              message = "无法连接服务器";
              break;
            case 405:
              message = "请求方法被禁止";
              break;
            case 500:
              message = "服务器内部错误";
              break;
            case 502:
              message = "无效的请求";
              break;
            case 503:
              message = "服务器出错";
              break;
            case 505:
              message = "不支持HTTP协议请求";
              break;
            default:
              message = "未知错误";
              break;
          }
        } on Exception catch (_) {
          message = e.error;
        }
      } else if (e.type == DioErrorType.cancel) {
        // to be continue...
        message = e.error;
      } else {
        // dio将原error重新套了一层
        e = e.error;
        if (e is UnauthorisedException) {
          stackTrace = null;
          errorType = ViewStateErrorType.unauthorizedError;
        } else if (e is UnSuccessException) {
          stackTrace = null;
          message = e.message;
        } else if (e is SocketException) {
          errorType = ViewStateErrorType.netWorkError;
          message = e.message;
        } else {
          message = e.message;
        }
      }
    } else if (e is Exception) {
      message = e.toString();
    } else if (e is Error) {
      message = e.stackTrace.toString();
    } else {
      message = "未知错误";
    }
    viewState = ViewState.error;
    _viewStateError =
        ViewStateError(errorType, errorMessage: e.toString(), message: message);
    printErrorStack(e, stackTrace);
    onError(viewStateError);
  }

  void onError(ViewStateError viewStateError) {}

  /// 显示错误消息
  showErrorMessage(context, {String message}) {
    if (viewStateError != null || message != null) {
      if (viewStateError.isNetworkError) {
        message ??= "加载失败";
      } else {
        message ??= viewStateError.message;
      }
      Future.microtask(() {
        ToastUtils.show(message);
      });
    }
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $_viewStateError}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    // debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }
}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
}
