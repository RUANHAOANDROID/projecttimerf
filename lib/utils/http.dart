import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ptf/config.dart';
import 'package:ptf/main.dart';
import '../constants.dart';
import 'dart:developer';
class HttpUtils {
  static Dio? dio;
  static var url;
  /// 生成Dio实例
  static Dio getInstance() {
    if (dio == null) {
      //通过传递一个 `BaseOptions`来创建dio实例
      var options = BaseOptions(
          baseUrl: url,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          headers: {
            'Content-Type':'application/json',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Expose-Headers":
                "Content-Length, Access-Control-Allow-Origin, Access-Control-Allow-Headers, Cache-Control, Content-Language, Content-Type",
            "Access-Control-Allow-Methods": "*",
            "Access-Control-Allow-Credentials": "true",
          });
      dio = Dio(options);
    }
    return dio!;
  }

  /// 请求api
  static Future<Map<String, dynamic>> request(String path,
      {data, method}) async {
    data = data ?? {};
    method = method ?? "get";
    // 打印请求相关信息：请求地址、请求方式、请求参数
    logger.d("------Dio Request-----\n$method\t$url\t$path\n"
        "${jsonEncode(data)}");
    if(url == null ){
      var config =await loadConfig();
      logger.d("request config $config");
      url =config['address'];
    }
    logger.d("request ${url}");
    var dio = getInstance();
    var resp;
    if (method == "get") {
      // get
      var response = await dio.get(path);
      resp = response.data;
    } else {
      // post
      var response = await dio.post(path, data: data);
      resp = response.data;
    }
    //debugger(message: "response");
    logger.d(resp);
    return resp;
  }
  /// get
  static Future<Map<String, dynamic>> get(path, data) =>
      request(path, data: data);

  /// post
  static Future<Map<String, dynamic>> post(path, data) =>
      request(path, data: data, method: "post");
}
