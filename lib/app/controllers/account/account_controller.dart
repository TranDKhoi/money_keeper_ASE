import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/core/utils/get_storage_service.dart';
import 'package:money_keeper/app/core/utils/localization_service.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../../data/models/user.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/storage_service.dart';
import '../../core/utils/utils.dart';
import '../../core/values/theme.dart';
import '../../modules/category/manage_category.dart';

class AccountController extends GetxController {
  var isDarkMode = false.obs;
  var isVietnamese = false.obs;
  var currentUser = Rxn<User>();

  void pickAvatar() async {
    String? picked = await ImageHelper.ins.pickAvatar();
    if (picked != null) {
      EasyLoading.show();
      var res = await StorageService.ins.uploadImageToStorage(File(picked));
      EasyLoading.dismiss();
      if (res != null) {
        print(res);
        EasyLoading.show();
        var result = await AuthService.ins.updateAvatar(res);
        EasyLoading.dismiss();
        if (result.isOk) {
          currentUser.value?.avatar = res;
          print(result.isOk);
        } else {
          print(result.statusText);
        }
      }
    }
  }

  void toMyWalletScreen() {
    Get.toNamed(myWalletRoute);
  }

  void toManageCategoryScreen() {
    Get.to(() => ManageCategoryScreen(canBack: false));
  }

  void toManageInvitationScreen() {
    Get.toNamed(manageInvitationRoute);
  }

  void toSettingScreen() {
    Get.toNamed(settingRoute);
  }

  void toLoginScreen() {
    GetStorageService.ins.clearUserToken();
    Get.offAllNamed(mainAuthScreenRoute);
  }

  void changeThemeMode(bool val) {
    isDarkMode.value = val;
    if (val) {
      Get.changeTheme(AppColors.darkTheme);
    } else {
      Get.changeTheme(AppColors.lightTheme);
    }
    GetStorageService.ins.setAppTheme(isDarkMode.value);
  }

  void changeLanguage(bool val) {
    isVietnamese.value = val;
    if (val) {
      LocalizationService.changeLocale("vi");
    } else {
      LocalizationService.changeLocale("en");
    }
    GetStorageService.ins.setAppLanguage(isVietnamese.value);
  }
}
