import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData(
      {@required url,
      Map<String, dynamic> query,
      @required Map<String, dynamic> data,
      String lang,
      String token}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'lang': lang = 'en',
      "Authorization": token ?? '',
    };
    return dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> getData(
      {@required String url,
      Map<String, dynamic> quires,
      String token,
      String lang}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": token ?? '',
      'lang': lang = 'en',
    };
    return await dio.get(
      url,
      queryParameters: quires,
    );
  }

  static Future<Response> putData(
      {@required String url,
      @required Map<String, dynamic> data,
      Map<String, dynamic> quires,
      String token,
      String lang}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": token ?? '',
      'lang': lang = 'en',
    };
    return await dio.put(
      url,
      queryParameters: quires,
      data: data,
    );
  }
}
