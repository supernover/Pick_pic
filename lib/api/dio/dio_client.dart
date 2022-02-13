import 'package:dio/dio.dart';
import 'package:pick_pic/common/config.dart';

/// get a dio instance
class DioClient {
  Dio init() {
    var _dio = Dio();

    if (Config.needAPILog) _dio.interceptors.add(DioInterceptors());

    _dio.options = BaseOptions(
      baseUrl: Config.baseUrl,
      headers: <String, dynamic>{
        'Authorization': 'Client-ID ${Config.AccessKey}'
      },
      connectTimeout: Config.connectTimeout,
      receiveTimeout: Config.receiveTimeout,
    );
    return _dio;
  }
}

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    print('It Was Me, Dio!');
    print('method = ${options.method.toString()}');
    print('url = ${options.uri.toString()}');
    print('headers = ${options.headers}');
    print('params = ${options.queryParameters}');
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    print('I REJECT MY HUMANITY, JOJO!');
    print('type = ${err.type}');
    print('message = ${err.message}');
    print('stackTrace = ${err.stackTrace}');

    switch (err.type) {
      case DioErrorType.connectTimeout:
        break;
      case DioErrorType.receiveTimeout:
        break;
      case DioErrorType.sendTimeout:
        break;
      case DioErrorType.response:
        break;
      case DioErrorType.cancel:
        break;
      default:
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    print('code = ${response.statusCode}');
    print('data = ${response.data}');
  }
}
