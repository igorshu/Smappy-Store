import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:smappy_store/core/api/products/category.dart';
import 'package:smappy_store/core/api/products/product.dart';
import 'package:smappy_store/core/api/products/product_record.dart';
import 'package:smappy_store/logic/settings_bloc/shop_data.dart';

class LocalRepo {

  static const _token = 'token';
  static const _shopId = 'shop_id';
  static const _categories = 'categories';
  static const _shopData = 'shopData';
  static const _photo = 'photo';
  static const _allowCountryDelivery = 'allowCountryDelivery';
  static const _products = 'products';

  static _toStringOrNull(jsonable) => jsonEncode(jsonable?.toJson());

  static ShopData? _fromString(Object? s) => s == null ? null : ShopData.fromJson(jsonDecode(s as String));

  /* SHOP DATA */

  static Future<void> saveShopData(ShopData? shopData) async {
    await GetIt.I<RxSharedPreferences>().write<ShopData>(_shopData, shopData, _toStringOrNull);
  }

  static Future<ShopData?> getShopData() async {
    return GetIt.I<RxSharedPreferences>().read<ShopData>(_shopData, _fromString);
  }

  /* COUNTRY DELIVERY */

  static Future<void> saveCountryDelivery(bool? allowCountryDelivery) async {
    await GetIt.I<RxSharedPreferences>().setBool(_allowCountryDelivery, allowCountryDelivery);
  }

  static Future<bool?> getCountryDelivery() async {
    return GetIt.I<RxSharedPreferences>().getBool(_allowCountryDelivery);
  }

  /* PHOTO */

  static Future<void> savePhoto(String? photo) async {
    await GetIt.I<RxSharedPreferences>().setString(_photo, photo);
  }

  static Future<String?> getPhoto() async {
    return GetIt.I<RxSharedPreferences>().getString(_photo);
  }

  /* TOKEN */

  static Future<void> saveToken(String? token) async {
    await GetIt.I<RxSharedPreferences>().setString(_token, token);
  }

  static Future<String?> getToken() async {
    return await GetIt.I<RxSharedPreferences>().getString(_token);
  }

  static Stream<String?> listenToken() {
    return GetIt.I<RxSharedPreferences>().getStringStream(_token);
  }

  static Future<void> clearToken() async {
    return await GetIt.I<RxSharedPreferences>().setString(_token, '');
  }

  /* SHOP ID */

  static Future<void> saveShopId(int id) async {
    await GetIt.I<RxSharedPreferences>().setInt(_shopId, id);
  }

  static Future<int?> getShopId() async {
    return GetIt.I<RxSharedPreferences>().getInt(_shopId);
  }

  /* CATEGORIES */

  static Future<void> saveCategories(List<Category> categories) async {
    var categoryList = categories.map((category) => json.encode(category.toJson())).toList();
    await GetIt.I<RxSharedPreferences>().setStringList(_categories, categoryList);
  }

  static Future<List<Category>> getCategories() async  {
    List<String> categoryList = await GetIt.I<RxSharedPreferences>().getStringList(_categories) ?? [];
    return categoryList.map((string) => Category.fromJson(json.decode(string))).toList();
  }

  /* PRODUCTS */

  static Future<void> saveProductRecords(List<ProductRecord> productRecords) async {
    var productRecordList = productRecords.map((productRecord) => json.encode(productRecord.toJson())).toList();
    await GetIt.I<RxSharedPreferences>().setStringList(_products, productRecordList);
  }

  static Future<List<ProductRecord>> getProductRecords() async {
    List<String> productRecordList = await GetIt.I<RxSharedPreferences>().getStringList(_products) ?? [];
    return productRecordList.map((string) => ProductRecord.fromJson(json.decode(string))).toList();
  }

  static Future<List<Product>> syncProductRecords(List<Product> remoteProducts) async {
    List<ProductRecord> productRecords = await getProductRecords();
    for(var remoteProduct in remoteProducts) {
      if (productRecords.indexWhere((ProductRecord pr) => pr.product.id == remoteProduct.id) == -1) {
        productRecords.add(ProductRecord.fromProduct(remoteProduct));
      }
    }
    await saveProductRecords(productRecords);
    return productRecords.where((pr) => !pr.deleted).map<Product>((e) => e.product).toList();
  }
}