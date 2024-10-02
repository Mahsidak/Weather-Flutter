import 'package:dio/dio.dart';
import 'DioClient.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dioClient.dio.get(path, queryParameters: queryParams);
      return response;
    } on DioError catch (e) {
      throw Exception('GET request error: ${e.message}');
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dioClient.dio.post(path, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('POST request error: ${e.message}');
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dioClient.dio.put(path, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('PUT request error: ${e.message}');
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dioClient.dio.delete(path, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('DELETE request error: ${e.message}');
    }
  }
}