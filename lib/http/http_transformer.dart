import 'package:dio/dio.dart';
import 'package:flutter_wan_android/http/http_response.dart';

abstract class HttpTransformer {
  HttpResponse parse(Response response);
}