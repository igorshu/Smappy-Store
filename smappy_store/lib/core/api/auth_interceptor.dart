import 'package:dio/dio.dart';
import 'package:smappy_store/core/repository/local_repo.dart';

class AuthInterceptor extends Interceptor {

  String? token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    token ??= LocalRepo.getToken();
    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    handler.next(options);
  }

}