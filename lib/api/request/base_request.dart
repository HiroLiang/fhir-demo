enum HttpMethod { get, post, put, delete }

abstract class BaseRequest {
  // 定義請求類型
  HttpMethod get method;

  // 定義 host 對象，預設請求路徑
  String get host => 'https://host-to-fhir-server:port';

  // 定義請求 path 與 query string 與 path variable
  String get pathTemplate;
  String getPath() {
    // 替換佔位符 ( path variable )
    String path = pathTemplate.replaceAllMapped(RegExp(r'{(.*?)}'), (match) {
      String key = match.group(1)!;
      return pathVar[key] ?? match.group(0)!;
    });

    // 填充 query string
    if (queryStr.isNotEmpty) {
      final String params =
          queryStr.entries.map((e) => '${e.key}=${e.value}').join('&');
      path = '$path?$params';
    }
    return path;
  }

  // request header ( 為 post 預填 content-type )
  Map<String, dynamic>? get header {
    switch (method) {
      case HttpMethod.post:
        return <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        };
      default:
        return null;
    }
  }

  Map<String, dynamic> get pathVar => {};
  Map<String, dynamic> get queryStr => {};
  Map<String, dynamic>? get body;

  String url() {
    return host + getPath();
  }
}
