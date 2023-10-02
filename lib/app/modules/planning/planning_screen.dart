import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../controllers/wallet/my_wallet_controller.dart';
import '../../core/values/r.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.Planning.tr),
        automaticallyImplyLeading: false,
      ),
      //////////////////
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              final currentWallets =
                  List.from(Get.find<MyWalletController>().listWallet);
              if (currentWallets.isEmpty) {
                EasyLoading.showToast(R.Walleterror.tr);
                return;
              }
              Get.toNamed(budgetScreenRoute);
            },
            contentPadding: const EdgeInsets.all(20),
            leading: const Icon(
              Ionicons.pie_chart,
              color: Colors.green,
              size: 30,
            ),
            trailing: const Icon(Ionicons.chevron_forward_outline),
            title: Text(
              R.Budget.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text(R.Afinancial.tr),
          ),
          ListTile(
            onTap: () => Get.toNamed(eventScreenRoute),
            contentPadding: const EdgeInsets.all(20),
            leading: const Icon(
              Ionicons.calendar_sharp,
              color: Colors.green,
              size: 30,
            ),
            trailing: const Icon(Ionicons.chevron_forward_outline),
            title: Text(
              R.Event.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            subtitle: Text(R.Createaneventto.tr),
          ),
        ],
      ),
    );
  }
}
