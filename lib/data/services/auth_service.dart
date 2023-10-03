import 'dart:convert';

import 'package:get/get.dart';

import '../../app/core/values/strings.dart';
import '../../app/features/account/controller/account_controller.dart';
import '../models/user.dart';

class AuthService extends GetConnect {
  AuthService._() {
    timeout = const Duration(seconds: 10);
  }

  static final ins = AuthService._();
  final AccountController _ac = Get.find();

  Future<Response> login({required User user}) async {
    return await post(
      "$baseUrl/auth/login",
      jsonEncode(user),
    );
  }

  Future<Response> signUp({required User user}) async {
    return await post(
      "$baseUrl/auth/register",
      jsonEncode(user),
    );
  }

  Future<Response> verifyAccount({required String email, required String code}) async {
    return await post(
      "$baseUrl/auth/verify-account",
      jsonEncode({"email": email, "code": code}),
    );
  }

  Future<Response> forgotPassword({required String email}) async {
    return await post(
      "$baseUrl/auth/forgot-password",
      jsonEncode({"email": email}),
    );
  }

  Future<Response> verifyResetPassword({required String email, required String code}) async {
    return await post(
      "$baseUrl/auth/verify-code-repassword",
      jsonEncode({"email": email, "code": code}),
    );
  }

  Future<Response> resetPassword({required String token, required String password}) async {
    return await post(
      "$baseUrl/auth/reset-password",
      jsonEncode({"token": token, "password": password}),
    );
  }

  Future<Response> updateAvatar(String avatar) {
    return put(
      "$baseUrl/account/info",
      {
        "avatar": avatar,
      },
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }

  Future<Response> getUserData() async {
    return await get("$baseUrl/auth", headers: <String, String>{
      'Authorization': _ac.currentUser.value!.token!,
    });
  }
}
