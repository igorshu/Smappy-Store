import 'package:dio/dio.dart';
import 'package:smappy_store/core/api/api_client.dart';
import 'package:smappy_store/core/api/auth_interceptor.dart';
import 'package:smappy_store/core/api/login/login_request.dart';
import 'package:smappy_store/core/api/login/login_response.dart';
import 'package:smappy_store/core/api/shop/shop_request.dart';
import 'package:smappy_store/core/api/shop/shop_response.dart';
import 'package:smappy_store/core/api/shop_registration/shop_registration_request.dart';
import 'package:smappy_store/core/api/shop_registration/shop_registration_response.dart';
import 'package:smappy_store/core/api/user_registration/user_registration_request.dart';
import 'package:smappy_store/core/api/user_registration/user_registration_response.dart';
import 'package:smappy_store/core/api/verify_phone_number/verify_phone_number_request.dart';
import 'package:smappy_store/core/api/verify_phone_number/verify_phone_number_response.dart';

class ApiRepo {

  static final AuthInterceptor _authInterceptor = AuthInterceptor();
  static final LogInterceptor _logInterceptor = LogInterceptor(responseBody: true, requestBody: true);

  static void setToken(String token) => _authInterceptor.token = token;

  static const int _timeout = 30*1000;

  static final _apiClient = ApiClient(
      Dio(
        BaseOptions(
          headers: {'accept': 'application/json'},
          connectTimeout: _timeout,
        )
      )..interceptors.addAll([
        _authInterceptor,
        _logInterceptor,
      ])
  );

  static Future<void> checkSmappyCode({required String smappyCode}) async {
    return await _apiClient.checkCode(smappyCode);
  }

  static Future<LoginResponse> login(String phone, String password) async {
    return await _apiClient.login(LoginRequest(phone, password));
  }

  static Future<UserRegistrationResponse> userRegistration(String phone) async {
    return await _apiClient.userRegistration(UserRegistrationRequest(phone));
  }

  static Future<ShopRegistrationResponse> shopRegistration(String phone, String code) async {
    return await _apiClient.shopRegistration(ShopRegistrationRequest(phone, code));
  }

  static Future<VerifyPhoneNumberResponse> shopVerifyPhoneNumber(int userId, String code) async {
    return await _apiClient.shopVerifyPhoneNumber(userId, VerifyPhoneNumberRequest(code));
  }

  static Future<ShopResponse> finishRegistration({
    String? password,
    String? shopName,
    String? shopAddress,
  }) async {
    var shopRequest = ShopRequest(
      name: shopName,
      password: password,
      address: shopAddress,
    );
    return await _apiClient.shop(shopRequest);
  }

}