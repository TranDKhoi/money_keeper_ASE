import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:money_keeper/app/features/bottom_bar/controller/bottombar_controller.dart';
import 'package:money_keeper/app/features/report/controller/report_controller.dart';

import '../../core/values/r.dart';
import '../my_wallet/controller/my_wallet_controller.dart';
import '../notification/controller/notification_controller.dart';
import '../transaction/controller/transaction_controller.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _controller = Get.put(BottomBarController());
  final walletController = Get.put(MyWalletController());
  final notificationController = Get.put(NotificationController());
  final transactionController = Get.put(TransactionController())..initData();
  final reportController = Get.put(ReportController())..initData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _controller.listPage[_controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: Border.all(width: .5, color: Colors.grey[400]!),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: BottomNavigationBar(
              currentIndex: _controller.currentIndex.value,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (i) => _controller.changePage(i),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Ionicons.home),
                  label: R.Home.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Ionicons.swap_horizontal_outline),
                  label: R.Transaction.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Ionicons.stats_chart),
                  label: R.Report.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Ionicons.calendar),
                  label: R.Planning.tr,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Ionicons.person),
                  label: R.Account.tr,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Ionicons.add, size: 30),
        onPressed: () {
          _controller.toCreateTransactionScreen();
        },
      ),
    );
  }
}
