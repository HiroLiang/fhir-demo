enum HttpMethod { GET, POST, PUT, DELETE }

abstract class BaseRequest {
  // 是否有 SSH 加密
  var useHttps = true;

  // 路徑參數
  String? pathVariable;

  String host() {
    return '';
  }

  HttpMethod httpMethod();

  // 請求 Mapping
  String path();

  // 請求 URL
  String url() {
    Uri uri;
    var pathStr = path();
    if (pathVariable != null) {
      if (pathStr.endsWith("/")) {
        pathStr = "${path()}$pathVariable";
      } else {
        pathStr = "${path()}/$pathVariable";
      }
    }
    if (useHttps) {
      uri = Uri.https(host(), pathStr, params);
    } else {
      uri = Uri.http(host(), pathStr, params);
    }
    return uri.toString();
  }

  // 是否登入
  bool needLogin();

  // 添加參數
  Map<String, String> params = Map();
  BaseRequest add(String key, String value) {
    params[key] = value.toString();
    return this;
  }

  // 添加Ｈeader
  Map<String, dynamic> header = Map();
  BaseRequest addHeader(String key, Object value) {
    header[key] = value.toString();
    return this;
  }
}
