// 网络异常统一格式类
class WanNetError implements Exception {
  final int errorCode;
  final String errorMsg;
  final dynamic data;

  WanNetError(this.errorCode, this.errorMsg, {this.data});
}
