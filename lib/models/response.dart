import 'dart:convert';

class Response<T> {
  int code;
  String msg;
  T data;

  Response({required this.code, required this.msg, required this.data});

  factory Response.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return Response(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: fromJsonT(json['data']),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'code': code,
      'msg': msg,
      'data': toJsonT(data),
    };
  }
}
