import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'End_Points.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(

        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(CurlLoggerDioInterceptor(
      printOnSuccess: true,
    ));
  }
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      print("token ${token}");

      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      };
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      print("dio.options $url");

      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      };
      final Response response = await dio.post(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print("response:$response");
      return response;
    } catch (e) {
      rethrow;
    }
  }
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': token ?? '',
      };
      final Response response = await dio.put(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
    bool files = false,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio.patch(
      url,
      data: data,
    );
  }
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    required String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    try {
      final Response response = await dio.delete(
        url,
        data: data,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}