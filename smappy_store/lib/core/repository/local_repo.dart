import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smappy_store/core/api/products/category.dart';

class LocalRepo {

  static const _token = 'token';
  static const _shopId = 'shop_id';
  static const _categories = 'categories';

  static Future<void> saveToken(String token) async {
    await GetIt.I<SharedPreferences>().setString(_token, token);
  }

  static String? getToken() {
    return GetIt.I<SharedPreferences>().getString(_token);
  }

  static Future<void> saveShopId(int id) async {
    await GetIt.I<SharedPreferences>().setInt(_shopId, id);
  }

  static int? getShopId()  {
    return GetIt.I<SharedPreferences>().getInt(_shopId);
  }

  static Future<void> saveCategories(List<Category> categories) async {
    var categoryList = categories.map((category) => json.encode(category.toJson())).toList();
    await GetIt.I<SharedPreferences>().setStringList(_categories, categoryList);
  }

  static List<Category> getCategories()  {
    List<String> categoryList = GetIt.I<SharedPreferences>().getStringList(_categories) ?? [];
    return categoryList.map((string) => Category.fromJson(json.decode(string))).toList();
  }
}