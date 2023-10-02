import 'dart:convert';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';
import 'package:money_keeper/app/core/values/strings.dart';

class UserService extends GetConnect {
  final AccountController _ac = Get.find();

  UserService._();

  static final ins = UserService._();

  Future<Response> checkAlreadyUser({required String email}) async {
    return await get(
      "$api_url/users/search?email=$email",
      headers: <String, String>{
        'Authorization': _ac.currentUser.value!.token!,
      },
    );
  }
}
