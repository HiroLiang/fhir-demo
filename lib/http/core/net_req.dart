import 'package:fhir_demo/http/request/base_request.dart';
import 'package:logger/web.dart';

final logger = Logger();

class NetReq {
  // dart 中的單例模式
  NetReq._();
  static NetReq? _instance;
  static NetReq getInstance() {
    return _instance ??= NetReq._();
  }

  Future fire(BaseRequest rq) async {
    var rs = await send(rq);
    var result = rs['data'];
    log('rs data : $result');
    return result;
  }

  Future<dynamic> send<T>(BaseRequest rq) async {
    log('url : ${rq.url()}');
    log('method : ${rq.httpMethod()}');

    rq.addHeader('Content-Type', 'application/json');
    log('header : ${rq.header}');

    return Future.value({
      'statusCode': 200,
      'data': {'code': 0, 'message': 'success'}
    });
  }

  void log(log) {
    logger.i('NetReq : ${log.toString()}');
  }
}
