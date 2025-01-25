import 'package:dio/dio.dart';
import 'package:wander/data/model/dio_reponse.dart';

class Connection {
  static final Connection _instance = Connection._internal();
  late Dio _dio;

  Connection._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com', 
        connectTimeout: const Duration(seconds: 10), 
        receiveTimeout: const Duration(seconds: 10), 
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  static Connection get instance => _instance;
  Future<DioResponse> get({required String url, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return DioResponse.success(response.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return DioResponse.failure('An unexpected error occurred: $e');
    }
  }

  Future<DioResponse> post({required String url, dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return DioResponse.success(response.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return DioResponse.failure('An unexpected error occurred: $e');
    }
  }

  Future<DioResponse> patch({required String url, dynamic data}) async {
    try {
      final response = await _dio.patch(url, data: data);
      return DioResponse.success(response.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return DioResponse.failure('An unexpected error occurred: $e');
    }
  }

  Future<DioResponse> delete({required String url, String? id}) async {
    try {
      final fullUrl = id != null ? "$url/$id" : url;
      final response = await _dio.delete(fullUrl);
      return DioResponse.success(response.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return DioResponse.failure('An unexpected error occurred: $e');
    }
  }

  DioResponse _handleDioError(DioException e) {
    if (e.response != null) {
      return DioResponse.failure(
        'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
      );
    } else {
      return DioResponse.failure(e.message ?? 'Network error occurred');
    }
  }
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  void clearHeaders() {
    _dio.options.headers.clear();
  }
}