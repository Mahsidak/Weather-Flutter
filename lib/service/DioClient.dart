import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioClient {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  DioClient() {
    _dio.options = BaseOptions(
      baseUrl: 'https://yourapi.com/api/',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        _logger.i('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        _logger.i('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response); // Continue with the response
      },
      onError: (DioError e, handler) {
        _logger.e('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        return handler.next(e); // Continue with the error
      },
    ));
  }

  Dio get dio => _dio;
}