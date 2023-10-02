import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';
import 'package:money_keeper/app/core/utils/push_service.dart';
import 'package:money_keeper/app/core/utils/utils.dart';
import 'package:money_keeper/data/services/auth_service.dart';

import 'app/app.dart';
import 'app/core/utils/get_storage_service.dart';
import 'app/core/utils/localization_service.dart';
import 'app/core/values/theme.dart';
import 'data/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await PushService.ins.init();
  ConfigHelper.configLoadingBar();
  _getUserToken();
  _getAppTheme();
  runApp(const App());
}

void _getUserToken() async {
  final ac = Get.put(AccountController());
  var token = GetStorageService.ins.getUserToken();
  if (token != null) {
    //get user by id
    ac.currentUser.value = User(token: token);
    var res = await AuthService.ins.getUserData();
    if (res.isOk) {
      ac.currentUser.value = User.fromJson(res.data);
      ac.currentUser.value?.token = token;
    }
  }
}

void _getAppTheme() {
  final ac = Get.find<AccountController>();
  var isDark = GetStorageService.ins.getAppTheme();
  ac.isDarkMode.value = isDark;

  if (isDark) {
    Get.changeTheme(AppColors.darkTheme);
  } else {
    Get.changeTheme(AppColors.lightTheme);
  }

  //Get language here
  var isVN = GetStorageService.ins.getAppLanguage();
  ac.isVietnamese.value = isVN;

  if (isVN) {
    LocalizationService.currentLocale = const Locale("vi", "VN");
  } else {
    LocalizationService.currentLocale = const Locale("en", "US");
  }
}
