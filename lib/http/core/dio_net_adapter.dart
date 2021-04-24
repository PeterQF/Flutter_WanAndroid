// Dio适配器
import 'package:dio/dio.dart';
import 'package:flutter_wan_android/http/core/wan_net_adapter.dart';
import 'package:flutter_wan_android/http/core/wan_net_error.dart';
import 'package:flutter_wan_android/http/request/wan_base_request.dart';

class DioAdapter extends WanNetAdapter {
  @override
  Future<WanResponse<T>> send<T>(BaseRequest request) async {
    /// Dio返回的response
    Response response;
    var options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      // 抛出WanAndroidNetError
      throw WanNetError(response?.statusCode ?? -1, error.toString(),
          data: buildResponse(response, request));
    }
    return buildResponse(response, request);
  }

  /// 将Dio的response构建成WanAndroidNetResponse
  buildResponse(response, BaseRequest request) {
    return WanResponse(
        data: response.data,
        request: request,
        errorCode: response.statusCode,
        errorMsg: response.statusMessage,
        extra: response);
  }
}
