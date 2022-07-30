import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smappy_store/core/api/add_save_product/add_product_response.dart';
import 'package:smappy_store/core/api/login/login_request.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/core/api/products/product.dart';
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
  Future<LoginResponse> userLogin(@Body() LoginRequest loginRequest);

  @POST('/shop/login')
  Future<LoginResponse> shopLogin(@Body() LoginRequest loginRequest);

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

  @GET('/product?sort=createdAt&order=asc')
  Future<List<Product>> products(@Query('offset') int offset, @Query('limit') int limit, @Query('shopId') int shopId);

  @POST('/product')
  @MultiPart()
  Future<ProductResponse> addProduct(
    @Part() String name,
    @Part() String description,
    @Part(name: 'web_site') String? webSite,
    @Part() String? categories,
    @Part() String? tags,
    @Part() double price,
    @Part(name: 'photos') List<File>? photos,
    @Part() bool? inGiftForList,
  );

  @PUT('/product/{productId}')
  @MultiPart()
  Future<ProductResponse> saveProduct(
    @Path() String productId,
    @Part() String name,
    @Part() String description,
    @Part(name: 'web_site') String? webSite,
    @Part() String? categories,
    @Part() String? tags,
    @Part() double price,
    @Part(name: 'photos') List<File>? photos,
    @Part() bool? inGiftForList,
  );

  @DELETE('/product/{productId}')
  Future<void> deleteProduct(@Path() String productId);

  @GET('/categories/{lang}')
  Future<List<Category>> getCategories(@Path() String lang);
}