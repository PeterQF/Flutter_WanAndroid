///页面状态类型
enum ViewState {
  idle,//空闲
  loading,//加载中
  empty,//无数据
  error,//失败
}

///错误类型
enum ViewStateErrorType {
  defaultError,
  netWorkError,// 网络错误
  unauthorizedError//未授权，一般为未登录
}

class ViewStateError {
  ViewStateErrorType _errorType;
  String errorMessage;
  String message;

  ViewStateError(this._errorType, {this.errorMessage, this.message}) {
    _errorType ??= ViewStateErrorType.defaultError;
    message ??= errorMessage;
  }

  ViewStateErrorType get errorType => _errorType;

  get isDefaultError => _errorType == ViewStateErrorType.defaultError;
  get isNetworkError => _errorType == ViewStateErrorType.netWorkError;
  get isUnauthorized => _errorType == ViewStateErrorType.unauthorizedError;


  @override
  String toString() {
    return 'ViewStateError{errorType: $_errorType, message: $message, errorMessage: $errorMessage}';
  }
}