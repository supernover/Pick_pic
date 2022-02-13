import 'dart:convert';
import 'package:dio/dio.dart';
import 'dio_client.dart';

/// http request manager
/// It Was Me, Dio!
class DioManager {
  final Dio _manager;

  static final DioManager _instance = DioManager._internal(DioClient().init());

  factory DioManager() => _instance;

  DioManager._internal(this._manager);

  /// get request
  Future<dynamic> get<T>(String path, {Map<String, dynamic>? params}) {
    return _request(path, method: 'get', params: params);
  }

  /// post request
  Future<dynamic> post<T>(String path, {Map<String, dynamic>? params, data}) {
    return _request(path, method: 'post', params: params, data: data);
  }

  Future<dynamic> _request(String path,
      {required String method, Map<String, dynamic>? params, data}) async {
    try {
      Response response = await _manager.request(path,
          queryParameters: params,
          data: data,
          options: Options(method: method));
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          // custom by server json
          // if (response.data['status'] != 200) {
          //   return Future.error(response.data!['msg'] as Object);
          // } else {
          //   return response.data;
          // }
          return response.data;
        } catch (e) {
          return Future.error('Json Error');
        }
      } else {
        _handleHttpError(response.statusCode!);
        return Future.error('HTTP Error');
      }
    } on DioError catch (ex) {
      String errorMessage =
          json.decode(ex.response.toString())['errorMessage'] as String;
      throw Exception(errorMessage);
    } catch (unKnow) {
      print(unKnow);
      return Future.error('Za Warudo!');
    }
  }

  static void _handleHttpError(int errorCode) {
    String message;
    switch (errorCode) {
      case 400:
        message = 'Bad Request';
        break;
      case 401:
        message = 'Unauthorized';
        break;
      case 403:
        message = 'Forbidden';
        break;
      case 404:
        message = 'Not Found';
        break;
      case 408:
        message = 'Request Timeout';
        break;
      case 500:
        message = 'Internal Server Error';
        break;
      case 501:
        message = 'Not Implemented';
        break;
      case 502:
        message = 'Bad Gateway';
        break;
      case 503:
        message = 'Service Unavailable';
        break;
      case 504:
        message = 'Gateway Timeout';
        break;
      case 505:
        message = 'HTTP Version Not Supported';
        break;
      default:
        message = 'error with ：$errorCode';
    }
    // do something about message
  }
}
