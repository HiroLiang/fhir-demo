import 'package:dio/dio.dart';
import 'package:fhir_demo/api/core/http_options.dart';
import 'package:fhir_demo/api/core/interceptor.dart';

class Request {
  Request._internal() {
    // 初始化 options
    BaseOptions options = BaseOptions(
        connectTimeout: HttpOptions.connectTimeout,
        receiveTimeout: HttpOptions.receiveTimeout,
        sendTimeout: HttpOptions.sendTimeout);

    // 懶漢加載
    dio = Dio(options);

    // 添加攔截器
    dio.interceptors.add(ErrorInterceptor());
  }

  factory Request() => _instance;

  static final Request _instance = Request._internal();

  static late final Dio dio;
}
