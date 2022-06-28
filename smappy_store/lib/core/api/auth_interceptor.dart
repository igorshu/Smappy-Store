import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {

  String? token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    handler.next(options);
  }

}