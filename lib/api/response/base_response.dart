import 'dart:convert';

class BaseResponse<T> {
  late T? data;
  late int? code;
  late String? msg;

  BaseResponse({this.code, this.msg, this.data});

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{ ');
    if (data is Map) {
      sb.write('"data": "${json.encode(data)}", ');
    } else {
      sb.write('"data": "${data.toString()}", ');
    }
    sb.write('"code": "$code", ');
    sb.write('"msg": "$msg" ');
    sb.write('}');
    return sb.toString();
  }
}
