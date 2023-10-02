import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/data/services/auth_service.dart';

import '../../core/values/r.dart';
import '../../routes/routes.dart';

class ForgotPassController extends GetxController {
  var isSecureText = true.obs;

  //----------------------------------------------------
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();
  final rePassTextController = TextEditingController();
  String? secureCode;
  String? resetPassToken;

  void toVerifyScreen() async {
    if (emailTextController.text.isNotEmpty) {
      EasyLoading.show();
      var res =
          await AuthService.ins.forgotPassword(email: emailTextController.text);
      EasyLoading.dismiss();

      if (res.isOk) {
        Get.toNamed(verifyForgotRoute);
      } else {
        EasyLoading.showToast(res.errorMessage);
      }
    } else {
      EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
    }
  }

  void changeSecureText() {
    isSecureText.value = !isSecureText.value;
  }

  void verifyCodeFunc() async {
    if (secureCode != null) {
      EasyLoading.show();
      var res = await AuthService.ins.verifyResetPassword(
          email: emailTextController.text, code: secureCode!);
      EasyLoading.dismiss();

      if (res.isOk) {
        Get.offAllNamed(resetPassRoute);
        resetPassToken = res.body["data"];
      } else {
        EasyLoading.showToast("Error");
      }
    } else {
      EasyLoading.showToast(R.Incorectcode.tr);
    }
  }

  void setNewPassFunc() async {
    if (passTextController.text.isNotEmpty &&
        rePassTextController.text.isNotEmpty) {
      if (passTextController.text == rePassTextController.text) {
        EasyLoading.show();
        var res = await AuthService.ins.resetPassword(
            token: resetPassToken!, password: rePassTextController.text);
        EasyLoading.dismiss();

        if (res.isOk) {
          Get.offAllNamed(loginScreenRoute);
          resetPassToken = null;
        } else {
          EasyLoading.showToast(res.errorMessage);
        }
      } else {
        EasyLoading.showToast(R.Incorectpassword.tr);
      }
    } else {
      EasyLoading.showToast(R.Pleaseenteralltheinformation.tr);
    }
  }
}
