import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/routes/routes.dart';

import '../../core/values/r.dart';
import '../my_wallet/controller/my_wallet_controller.dart';

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
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            R.Planning.tr,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      //////////////////
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            onTap: () {
              final currentWallets = List.from(Get.find<MyWalletController>().listWallet);
              if (currentWallets.isEmpty) {
                EasyLoading.showToast(R.Walleterror.tr);
                return;
              }
              Get.toNamed(budgetScreenRoute);
            },
            shape: const Border(
              top: BorderSide(color: Colors.black, width: 0.3),
              bottom: BorderSide(color: Colors.black, width: 0.3),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            leading: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey.withOpacity(0.1),
              child: Image.asset(
                "assets/icons/ic_budget.png",
                width: 28,
                height: 28,
              ),
            ),
            trailing: Icon(
              Ionicons.caret_forward_outline,
              color: Colors.blueGrey.withOpacity(0.7),
            ),
            title: Text(
              R.Budget.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(R.Afinancial.tr),
            ),
          ),
          ListTile(
            onTap: () => Get.toNamed(eventScreenRoute),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            leading: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey.withOpacity(0.1),
              child: Image.asset(
                "assets/icons/ic_event.png",
                width: 28,
                height: 28,
              ),
            ),
            shape: const Border(
              bottom: BorderSide(color: Colors.black, width: 0.3),
            ),
            trailing: Icon(
              Ionicons.caret_forward_outline,
              color: Colors.blueGrey.withOpacity(0.7),
            ),
            title: Text(
              R.Event.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(R.Createaneventto.tr),
            ),
          ),
        ],
      ),
    );
  }
}
