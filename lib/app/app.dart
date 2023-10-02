import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/controllers/account/account_controller.dart';
import 'package:money_keeper/app/routes/pages.dart';
import 'package:money_keeper/app/routes/routes.dart';

import 'core/utils/localization_service.dart';
import 'core/values/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      initialRoute:
          Get.find<AccountController>().currentUser.value?.token == null
              ? mainAuthScreenRoute
              : bottomBarRoute,
      builder: EasyLoading.init(),
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
      locale: LocalizationService.currentLocale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }
}
