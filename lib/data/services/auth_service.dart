import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

import '../../app/controllers/account/account_controller.dart';
import '../../app/core/values/strings.dart';
import '../models/user.dart';

class AuthService extends GetConnect {
  AuthService._() {
    timeout = const Duration(seconds: 10);
  }

  static final ins = AuthService._();
  final AccountController _ac = Get.find();

  Future<Response> login({required User user}) async {
    return await post(
      "$api_url/auth/login",
      jsonEncode(user),
    );
  }

  Future<Response> signUp({required User user}) async {
    return await post(
      "$api_url/auth/register",
      jsonEncode(user),
    );
  }

  Future<Response> verifyAccount(
      {required String email, required String code}) async {
    return await post(
      "$api_url/auth/verify-account",
      jsonEncode({"email": email, "code": code}),
    );
  }

  Future<Response> forgotPassword({required String email}) async {
    return await post(
      "$api_url/auth/forgot-password",
      jsonEncode({"email": email}),
    );
  }

  Future<Response> verifyResetPassword(
      {required String email, required String code}) async {
    return await post(
      "$api_url/auth/verify-code-repassword",
      jsonEncode({"email": email, "code": code}),
    );
  }

  Future<Response> resetPassword(
      {required String token, required String password}) async {
    return await post(
      "$api_url/auth/reset-password",
      jsonEncode({"token": token, "password": password}),
    );
  }

  Future<Response> updateAvatar(String avatar) {
    return put(
      "$api_url/account/info",
      {
        "avatar": avatar,
      },
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> getUserData() async {
    return await get("$api_url/auth", headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }
}
