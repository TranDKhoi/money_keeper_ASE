import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/app/routes/routes.dart';
import 'package:money_keeper/data/services/auth_service.dart';

import '../../../data/models/user.dart';
import '../../core/utils/get_storage_service.dart';
import '../../core/values/r.dart';

class LoginController extends GetxController {
  var isSecureText = true.obs;

  //----------------------------------------------------
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();
  int? secureCode;

  void changeSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  loginFunc() async {
    if (isValidData()) {
      User u = User(
          email: emailTextController.text, password: passTextController.text);

      EasyLoading.show();
      var res = await AuthService.ins.login(user: u);
      EasyLoading.dismiss();

      if (res.isOk) {
        final AccountController ac = Get.find();
        ac.currentUser.value = User.fromJson(res.data);
        ac.currentUser.value!.token = res.body["token"];
        //save to local
        GetStorageService.ins.setUserToken(ac.currentUser.value!.token!);

        Get.toNamed(bottomBarRoute);
      } else {
        EasyLoading.showToast(res.errorMessage);
      }
    } else {
      EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
    }
  }

  bool isValidData() {
    return emailTextController.text.isNotEmpty &&
        passTextController.text.isNotEmpty;
  }
}
