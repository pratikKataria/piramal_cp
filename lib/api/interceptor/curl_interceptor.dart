import 'package:dio/dio.dart';

class CurlInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("-- Request --");
    print("Curl: ${_getCurlCommand(options)}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print("-- Response --");
    // print("Curl: ${_getCurlCommand(response.requestOptions)}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // print("-- Error --");
    // print("Curl: ${_getCurlCommand(err.requestOptions)}");
    super.onError(err, handler);
  }

  String _getCurlCommand(RequestOptions options) {
    String curl = "curl -X ${options.method.toUpperCase()} '${options.uri.toString()}'";

    // Add headers to the CURL command
    if (options.headers != null) {
      options.headers.forEach((key, value) {
        curl += " -H '$key: $value'";
      });
    }

    // Add data (body) to the CURL command
    if (options.method != "GET" && options.data != null) {
      curl += " -d '${options.data}'";
    }

    return curl;
  }
}
