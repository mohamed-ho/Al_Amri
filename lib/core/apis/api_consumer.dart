import 'dart:io';

abstract class ApiConsumer {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String url,
      {Map<String, dynamic>? queryParameters, Map<String, dynamic>? body});
  Future<dynamic> put(String url,
      {Map<String, dynamic>? queryParameters, Map<String, dynamic>? body});
  Future<dynamic> uplaodFile(
      {required String url, required File file, Map<String, dynamic>? body});
}
