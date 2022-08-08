import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    //create place data 7tegy mnh

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> getData({
    // method ely 7tgeeb data
    required String url,
    required Map<String, dynamic>? query,
    String lang = "ar",
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    // method ely 7tpost data
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "ar",
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data, //keys in body in post man
    );
  }
}
