import 'dart:convert';
import 'dart:io';
import 'package:alamri_adm/core/apis/api_consumer.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/core/apis/status_code.dart';
import 'package:alamri_adm/core/errors/exceptions.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;
  final String _basicAuth =
      'Basic ${base64Encode(utf8.encode('mohamed:mohamed110'))}';

  DioConsumer({required this.client}) {
    if (kIsWeb) {
    } else {
      (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
          HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
    }
    client.options
      ..headers = {'authorization': _basicAuth}
      ..baseUrl = EndPoints.baseURL
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await client.get(
        url,
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        return _handelResposeAsJson(response);
      } else {
        throw ServerExceptions(response.statusCode.toString());
      }
    } on DioException catch (exception) {
      _handleDioError(exception);
    }
  }

  @override
  Future post(String url,
      {Map<String, dynamic>? queryParameters,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? body}) async {
    try {
      var response = await client.post(
        url,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return _handelResposeAsJson(response);
    } on DioException catch (exception) {
      _handleDioError(exception);
    }
  }

  @override
  Future put(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body}) async {
    try {
      var response =
          await client.put(url, queryParameters: queryParameters, data: body);
      return _handelResposeAsJson(response);
    } on DioException catch (exception) {
      _handleDioError(exception);
    }
  }

  @override
  Future uplaodFile(
      {required String url, File? file, Map<String, dynamic>? body}) async {
    FormData formData;
    if (body != null) {
      formData = FormData.fromMap({
        "imageFile": await MultipartFile.fromFile(
          file!.path,
          filename: basename(file.path),
        ),
        ...body,
      });
    } else {
      formData = FormData.fromMap({
        "imageFile": await MultipartFile.fromFile(
          file!.path,
          filename: basename(file.path),
        ),
      });
    }
    try {
      final response = await client.post(url, data: formData);
      return _handelResposeAsJson(response);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future uploadImage(
      {required String url,
      Uint8List? image,
      Map<String, dynamic>? body}) async {
    try {
      FormData formData = FormData.fromMap({
        'imageFile': MultipartFile.fromBytes(image!.toList(),
            filename: 'mohamed hosny hassan'),
        ...body!
      });
      final response = await client.post(url, data: formData);
      if (response.statusCode == 200) {
        print('اخيرا اخيرااااااااااااااااااااااااااااااااااااااااااااا');
        print(response.data);
      }
    } catch (e) {
      print('you have errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror $e');
    }
  }

  dynamic _handelResposeAsJson(Response<dynamic> response) {
    return jsonDecode(response.data.toString());
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();

          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();

      default:
        throw const NoInternetConnectionException();
    }
  }
}
