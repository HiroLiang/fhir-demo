import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    HttpException httpException = HttpException.create(err);

    DioException error = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: httpException
    );
    super.onError(error, handler);
  }
  
}

class HttpException implements Exception {
  final int code;
  final String msg;

  HttpException({
    this.code = -1,
    this.msg = '未知錯誤'
  });
  
  @override
  String toString (){
    return 'Http error [$code] : $msg';
  }

  factory HttpException.create(DioException err) {
    if(err.response != null){
      int statusCode = err.response?.statusCode ?? 0;
      String statusMessage = err.response?.statusMessage ?? '';
      switch(statusCode){
        case 400:
          return HttpException(code:400, msg: '請求無效');
        case 401:
          return HttpException(code:400, msg: '未授權');
        case 403:
          return HttpException(code:400, msg: '訪問被拒絕');
        case 404:
          return HttpException(code:400, msg: '路徑不存在');
        case 405:
          return HttpException(code:400, msg: '訪問路徑不存在');
        case 500:
          return HttpException(code:400, msg: '伺服器錯誤');
        case 501:
          return HttpException(code:400, msg: '無法辨識請求');
        case 503:
          return HttpException(code:400, msg: '伺服器超載');
        case 504:
          return HttpException(code:400, msg: 'gate way超時');
        case 505:
          return HttpException(code:400, msg: 'Http 不支援');
        default:
          return HttpException(code: statusCode, msg: statusMessage);
      }
    }
    switch(err.type){
      case DioExceptionType.cancel: 
        return HttpException(code: -1, msg: '請求取消');
      case DioExceptionType.connectionTimeout:
        return HttpException(code: -1, msg: '請求連線時間過長');
      case DioExceptionType.sendTimeout:
        return HttpException(code: -1, msg: '請求超時');
      case DioExceptionType.receiveTimeout:
        return HttpException(code: -1, msg: '沒有回應');
      default:
        return HttpException(code: -1, msg: '未知錯誤');
    }

  }
}