import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smappy_store/core/api/login/login_request.dart';
import 'package:smappy_store/core/api/shop/shop_request.dart';
import 'package:smappy_store/core/api/shop/shop_response.dart';
import 'package:smappy_store/core/api/shop_registration/shop_registration_request.dart';
import 'package:smappy_store/core/api/shop_registration/shop_registration_response.dart';
import 'package:smappy_store/core/api/user_registration/user_registration_request.dart';
import 'package:smappy_store/core/api/user_registration/user_registration_response.dart';
import 'package:smappy_store/core/api/verify_phone_number/verify_phone_number_request.dart';
import 'package:smappy_store/core/api/verify_phone_number/verify_phone_number_response.dart';

import 'login/login_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://ideaback.net/api/')
abstract class ApiClient {

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/user/login')
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET("/shop/check-code/{code}")
  Future<void> checkCode(@Path("code") String code);

  @POST('/user')
  Future<UserRegistrationResponse> userRegistration(@Body() UserRegistrationRequest userRegistrationRequest);

  @POST('/shop')
  Future<ShopRegistrationResponse> shopRegistration(@Body() ShopRegistrationRequest shopRegistrationRequest);

  @PUT('/user/{userID}/verifyPhoneNumber')
  Future<VerifyPhoneNumberResponse> userVerifyPhoneNumber(@Path() int userID, @Body() VerifyPhoneNumberRequest verifyPhoneNumberRequest);

  @PUT('/shop/{shopID}/verifyPhoneNumber')
  Future<VerifyPhoneNumberResponse> shopVerifyPhoneNumber(@Path() int shopID, @Body() VerifyPhoneNumberRequest verifyPhoneNumberRequest);

  @PUT('/shop')
  Future<ShopResponse> shop(@Body() ShopRequest shopRequest);
}