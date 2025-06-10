import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/io.dart';
import 'dart:io';

class ApiClient {
  // Change this to your computer's IP address if testing on a physical device
  static const String baseUrl = "http://10.0.2.2:3444/";

  static Dio? _dio;

  static Dio get dio {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ));

      // Add logging interceptor
      _dio!.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ));

      // Add custom interceptor for logging
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('Making request to: ${options.uri}');
          debugPrint('Request headers: ${options.headers}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('Response code: ${response.statusCode}');
          debugPrint('Response headers: ${response.headers}');
          return handler.next(response);
        },
      ));

      // Configure SSL for HTTPS
      if (baseUrl.startsWith('https')) {
        (_dio!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
            (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
      }
    }
    return _dio!;
  }

  // API instances
  static final IdeaApi ideaApi = IdeaApi(dio);
  static final FeedbackApi feedbackApi = FeedbackApi(dio);
  static final AuthApi authApi = AuthApi(dio);
  static final UserApi userApi = UserApi(dio);
  static final ApiService apiService = ApiService(dio);
} 