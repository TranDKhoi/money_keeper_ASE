import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/features/account/controller/account_controller.dart';

import '../../core/values/r.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AccountController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                const Text(
                  R.Account,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                const SizedBox(height: 20),
                //my wallet
                ListTile(
                  onTap: () {
                    _controller.toMyWalletScreen();
                  },
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    child: Image.asset(
                      "assets/icons/ic_wallet.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                  title: Text(
                    R.Mywallet.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Ionicons.caret_forward_outline,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  shape: const Border(
                    top: BorderSide(color: Colors.grey, width: 0.2),
                    bottom: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                ListTile(
                  onTap: () {
                    _controller.toManageCategoryScreen();
                  },
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    child: Image.asset(
                      "assets/icons/ic_category.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                  title: Text(
                    R.ManageCategory.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Ionicons.caret_forward_outline,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                ListTile(
                  onTap: () {
                    _controller.toManageInvitationScreen();
                  },
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    child: Image.asset(
                      "assets/icons/ic_invitation.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                  title: Text(
                    R.invitation.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Ionicons.caret_forward_outline,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                //setting
                ListTile(
                  onTap: () {
                    _controller.toSettingScreen();
                  },
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    child: Image.asset(
                      "assets/icons/ic_setting.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                  title: Text(
                    R.Setting.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Ionicons.caret_forward_outline,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                //log out
                ListTile(
                  onTap: () {
                    _controller.toLoginScreen();
                  },
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    child: Image.asset(
                      "assets/icons/ic_signout.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                  title: Text(
                    R.Signout.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Icon(
                    Ionicons.caret_forward_outline,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
