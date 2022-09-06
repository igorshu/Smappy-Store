import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smappy_store/core/api/add_save_product/add_product_response.dart';
import 'package:smappy_store/core/api/api_client.dart';
import 'package:smappy_store/core/api/auth_interceptor.dart';
import 'package:smappy_store/core/api/balance/balance_response.dart';
import 'package:smappy_store/core/api/cities/city_request.dart';
import 'package:smappy_store/core/api/login/login_request.dart';
import 'package:smappy_store/core/api/orders/order.dart';
import 'package:smappy_store/core/api/payment_info/payment_info.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/core/api/shop/shop_request.dart';
import 'package:smappy_store/core/api/shop/shop_response.dart';
import 'package:smappy_store/core/api/shop_registration/shop_registration_request.dart';
import 'package:smappy_store/core/api/shop_registration/shop_registration_response.dart';
import 'package:smappy_store/core/api/verify_phone_number/verify_phone_number_request.dart';
import 'package:smappy_store/core/api/verify_phone_number/verify_phone_number_response.dart';
import 'package:smappy_store/logic/settings_bloc/city.dart';

class ApiRepo {

  static final AuthInterceptor _authInterceptor = AuthInterceptor();
  static final LogInterceptor _logInterceptor = LogInterceptor(responseBody: true, requestBody: true);

  static void setAuthToken(String? token) => _authInterceptor.token = token;

  static const int _timeout = 5*1000;

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

  static Future<ShopResponse> shopLogin(String phone, String password) async {
    return await _apiClient.shopLogin(LoginRequest(phone, password));
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

  static Future<List<Product>> getProducts({required int shopId, int? offset = 0, int? limit = 100}) async {
    return await _apiClient.products(offset!, limit!, shopId);
  }

  static Future<ProductResponse> addProduct({
    required String name,
    required String description,
    String? webSite,
    String? categories,
    String? tags,
    required double price,
    List<File>? photos,
    bool? inGiftForList,
  }) async {
    return await _apiClient.addProduct(name, description, webSite, categories, tags, price, photos, inGiftForList);
  }

  static Future<ProductResponse> saveProduct({
    required String productId,
    required String name,
    required String description,
    String? webSite,
    String? categories,
    String? tags,
    required double price,
    List<File>? photos,
    bool? inGiftForList,
  }) async {
    return await _apiClient.saveProduct(productId, name, description, webSite, categories, tags, price, photos, inGiftForList);
  }

  static Future<void> deleteProduct(String productId) async {
    return _apiClient.deleteProduct(productId);
  }

  static Future<List<Category>> getCategories(String lang) async {
    return await _apiClient.getCategories(lang);
  }

  static Future<PaymentInfo> getPaymentInfo() async {
    return await _apiClient.getPaymentInfo();
  }

  static Future<String> savePaymentInfo(PaymentInfo paymentInfo) async {
    return await _apiClient.savePaymentInfo(paymentInfo);
  }

  static Future<void> deleteShop(String phone) async {
    return await _apiClient.deleteShop(phone);
  }

  static Future<List<Order>> getOrders() async {
    return await _apiClient.getOrders();
  }

  static Future<BalanceResponse> getBalance() async {
    return await _apiClient.getBalance();
  }

  static Future<String> changeOrderStatus(orderId, status) async {
    return await _apiClient.changeOrderStatus(orderId, status);
  }

  static Future<ShopResponse> saveShop({
    String? name,
    String? description,
    String? address,
    String? whatsapp,
    String? telegram,
    String? email,
  }) async {
    var shopRequest = ShopRequest(
      name: name,
      description: description,
      address: address,
      whatsapp: whatsapp,
      instagram: telegram,
      email: email,
    );
    return await _apiClient.shop(shopRequest);
  }

  static Future<ShopResponse> addAvatar({required File image}) {
    return _apiClient.addAvatar(image);
  }

  static Future<ShopResponse> saveDelivery({required bool everywhere}) {
    return _apiClient.shop(
      ShopRequest(
        allowCountryDelivery: everywhere,
      )
    );
  }

  static Future<String> addCity({required City city}) async {
    return await _apiClient.addCity(CityRequest(placeId: city.placeId, name: city.name, lang: 'ru'));
  }

  static Future<String> removeCity({required String placeId}) async {
    return await _apiClient.removeCity(CityRequest(placeId: placeId));
  }

  static Future<List<City>> getMyCities() async {
    return await _apiClient.getMyCities();
  }

  static Future<ShopResponse> getShop() async {
    return _apiClient.getShop(ShopRequest());
  }
}
