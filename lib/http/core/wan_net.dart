import 'package:flutter_wan_android/http/core/dio_net_adapter.dart';
import 'package:flutter_wan_android/http/core/wan_net_adapter.dart';
import 'package:flutter_wan_android/http/core/wan_net_error.dart';
import 'package:flutter_wan_android/http/request/wan_base_request.dart';

class WanNet {
  WanNet._();
  static WanNet _instance;
  static WanNet getInstance() {
    if (_instance == null) {
      _instance = WanNet._();
    }
    return _instance;
  }

  Future<WanResponse<dynamic>> fire(BaseRequest request) async {
    WanResponse response;
    var error;
    try {
      response = await send(request);
    } on WanNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.errorMsg);
    } catch (e) {
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    return response;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url: ${request.url()}');
    // 使用Dio发送请求，如果要用其他网络框架，继承自WanAndroidNetAdapter，然后在这切换即可
    DioAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('wan_android: ${log.toString()}');
  }
}
