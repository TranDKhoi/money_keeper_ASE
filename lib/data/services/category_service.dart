import 'dart:convert';

import 'package:get/get.dart';

import '../../app/controllers/account/account_controller.dart';
import '../../app/core/values/strings.dart';
import '../models/category.dart';

class CategoryService extends GetConnect {
  final AccountController _ac = Get.find();

  CategoryService._(){
    timeout = const Duration(seconds: 10);
  }

  static final ins = CategoryService._();

  Future<Response> getAllCategory() async {
    return await get("$api_url/categories");
  }

  Future<Response> getCategoryByWalletId(int id) async {
    return await get(
      "$api_url/wallets/$id/categories",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> createCategoryByWalletId(Category createCate) async {
    return await post(
      "$api_url/wallets/${createCate.walletId}/categories/",
      jsonEncode(createCate),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> updateCategoryByWalletId(Category editCate) async {
    return await put(
      "$api_url/wallets/${editCate.walletId}/categories/${editCate.id}",
      jsonEncode(editCate),
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> deleteCategoryByWalletId(Category delCate) async {
    print(delCate.id);
    return await delete(
      "$api_url/wallets/${delCate.walletId}/categories/${delCate.id}",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }
}
