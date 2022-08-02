import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    //create place data 7tegy mnh

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    // method ely 7tgeeb data
    required String url,
    required Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
