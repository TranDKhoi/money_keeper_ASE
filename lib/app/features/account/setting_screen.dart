import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/features/account/controller/account_controller.dart';

import '../../core/values/r.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final AccountController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Setting.tr),
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.withOpacity(0.1),
              child: Image.asset(
                "assets/icons/ic_darkmode.png",
                width: 28,
                height: 28,
              ),
            ),
            title: Text(
              R.Darkmode.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Obx(
              () => Switch(
                activeColor: const Color(0xffFC7361),
                inactiveThumbColor: const Color(0xff859BB5),
                onChanged: (val) {
                  _controller.changeThemeMode(val);
                },
                value: _controller.isDarkMode.value,
              ),
            ),
            shape: const Border(
              bottom: BorderSide(color: Colors.grey, width: 0.2),
              top: BorderSide(color: Colors.grey, width: 0.2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.withOpacity(0.1),
              child: Image.asset(
                "assets/icons/ic_language.png",
                width: 28,
                height: 28,
              ),
            ),
            title: Text(R.Vietnamese.tr),
            trailing: Obx(
              () => Switch(
                onChanged: (val) {
                  _controller.changeLanguage(val);
                },
                value: _controller.isVietnamese.value,
                activeColor: const Color(0xffFC7361),
                inactiveThumbColor: const Color(0xff859BB5),
              ),
            ),
            shape: const Border(
              bottom: BorderSide(color: Colors.grey, width: 0.2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ],
      ),
    );
  }
}
