import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConfig.connectTimeout),
      receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
      sendTimeout: Duration(milliseconds: ApiConfig.sendTimeout),
      headers: ApiConfig.defaultHeaders,
    ));

    // Add logging interceptor in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ));
    }

    // Add error handling interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
        debugPrint('Dio Error: ${error.message}');
        debugPrint('Error Response: ${error.response?.data}');
        return handler.next(error);
      },
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        debugPrint('Making request to: ${options.uri}');
        debugPrint('Request headers: ${options.headers}');
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        debugPrint('Response code: ${response.statusCode}');
        debugPrint('Response headers: ${response.headers}');
        return handler.next(response);
      },
    ));
  }

  Dio get dio => _dio;

  // Helper method to add auth token to requests
  void addAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Helper method to remove auth token
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
} 